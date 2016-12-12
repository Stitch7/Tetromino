//
//  WindowManager.swift
//  TetrominoCurses
//
//  Created by Christopher Reitz on 12/12/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import Darwin.ncurses

final class WindowManager {

    typealias Window = OpaquePointer

    // MARK: - Properties

    let game: Game<SquareView>
    var gameWindow: Window
    let levelWindow: Window
    let scoreWindow: Window
    let highscoreWindow: Window
    let nextPieceWindow: Window
    let gameOverWindow: Window
    let gameOverSubWindow: Window

    // MARK: - Initializers

    init(game: Game<SquareView>) {
        self.game = game

        initscr()
        noecho()
        keypad(stdscr, true)
        curs_set(0)
        refresh()
        Color.initCurses()

        gameWindow        = newwin(42, 42,  3,  3)!
        levelWindow       = newwin( 5, 20,  3, 47)!
        scoreWindow       = newwin( 6, 20,  8, 47)!
        highscoreWindow   = newwin( 6, 20, 14, 47)!
        nextPieceWindow   = newwin(14, 20, 20, 47)!
        gameOverWindow    = newwin( 7, 25, 20, 11)!
        gameOverSubWindow = newwin( 3, 36, 40,  6)!
    }

    // MARK: - Public

    func run(userInput: Input) {
        game.newGame()

        drawTitle()

        wclear(gameWindow)
        wclear(nextPieceWindow)
        redrawGameWindow()
        redrawNextPieceWindow()

        userInput.waitForInput()
        endwin()
    }

    func drawTitle() {
        mvaddstr(2, 4, "T E T R O M I N O")
    }

    func redraw(window: Window, handler: (Window) -> Void) {
        werase(window)

        handler(window)

        box(window, 0, 0)
        wrefresh(window)
    }

    func redrawGameWindow(board: Board<SquareView>? = nil, handler: ((Window) -> Void)? = nil) {
        redraw(window: gameWindow) { gameWindow in
            redrawBoard(board: board)
            handler?(gameWindow)
        }
    }

    func redrawGameOverWindow() {
        redraw(window: gameOverWindow) { (gameOverWindow) in
            mvwaddstr(gameOverWindow, 3, 7, "GAME OVER")
        }

        redraw(window: gameOverSubWindow) { (gameOverSubWindow) in
            mvwaddstr(gameOverSubWindow, 1, 3, "Press ENTER to start New Game")
        }
    }

    func redrawLevelWindow(level newLevel: Level) {
        redraw(window: levelWindow) { (levelWindow) in
            mvwaddstr(levelWindow, 2, 3, "LEVEL \(newLevel.number)")
        }
    }

    func redrawScoreWindow(score newScore: Score) {
        redraw(window: scoreWindow) { (scoreWindow) in
            mvwaddstr(scoreWindow, 2, 3, "SCORE")
            mvwaddstr(scoreWindow, 3, 3, "\(newScore.value)")
        }
    }

    func redrawHighscoreWindow(highscore: Highscore) {
        redraw(window: highscoreWindow) { (highscoreWindow) in
            mvwaddstr(highscoreWindow, 2, 3, "HIGHSCORE")
            mvwaddstr(highscoreWindow, 3, 3, "\(highscore.leader)")
        }
    }

    func redrawNextPieceWindow() {
        redraw(window: nextPieceWindow) { nextPieceWindow in
            mvwaddstr(nextPieceWindow, 2, 3, "NEXT")
        }
    }

    func redrawNextPieceWindow<SquareView>(piece nextPiece: Piece<SquareView>) {
        redraw(window: nextPieceWindow) { nextPieceWindow in
            mvwaddstr(nextPieceWindow, 2, 3, "NEXT")

            var nextPieceVar = nextPiece
            nextPieceVar.build(width: 0, height: 0)
            for square in nextPieceVar.squares {
                let squareView = square.view as! TetrominoCurses.SquareView
                var config = square.view.config
                config.boardCol -= 3
                config.boardRow += 2
                squareView.draw(window: nextPieceWindow, config: config)
            }
        }
    }

    private func redrawBoard(board: Board<SquareView>?) {
        guard let board = board, board.grid.count > 0 else { return }
        board.walkAllSlots { row, col in
            guard let square = board.grid[row][col] else { return }
            square.view.draw(window: self.gameWindow, config: square.view.config)
        }
    }
}
