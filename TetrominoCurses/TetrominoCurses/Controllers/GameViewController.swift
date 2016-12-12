//
//  GameViewController.swift
//  TetrominoCurses
//
//  Created by Christopher Reitz on 11/12/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import Foundation

final class GameViewController {

    // MARK: - Properties

    let wm: WindowManager
    let game: Game<SquareView>
    let userInput: UserInput
    let highscore: Highscore
    var queue: DispatchQueue?

    // MARK: - Initializers

    init(wm: WindowManager, userInput: UserInput, highscore: Highscore) {
        self.wm = wm
        self.game = wm.game
        self.userInput = userInput
        self.highscore = highscore

        game.delegate = self
    }

    // MARK: - Interval

    func disableInterval() {
        queue = nil
    }

    func newInterval(level: Level) {
        queue = DispatchQueue(label: "interval")
        timer(level: level)
    }

    func timer(level: Level) {
        queue?.asyncAfter(deadline: .now() + level.speed) { [weak self] in
            self?.interval()
            self?.timer(level: level)
        }
    }

    func interval() {
        wm.redrawGameWindow(board: game.board) { gameWindow in
            self.game.tick()
        }

        if game.gameOver {
            wm.redrawGameOverWindow()
        }
    }
}

extension GameViewController: GameDelegate {
    func newGame() {
        game.new()
        wm.redrawHighscoreWindow(highscore: highscore)
    }

    public func pauseGame() {
    }

    func gameOver() {
        wm.redrawGameWindow(board: game.board)
        disableInterval()
        _ = highscore.save(value: game.score.value)
    }

    func display<SquareView>(piece: Piece<SquareView>) {
        wm.redrawGameWindow(board: game.board) { gameWindow in
            for square in piece.squares {
                guard let squareView = square.view as? TetrominoCurses.SquareView else {
                    fatalError("Wrong SquareViewType")
                }
                squareView.window = gameWindow
                squareView.draw(window: gameWindow, config: squareView.config)
            }
        }
    }

    func remove<SquareView>(piece: Piece<SquareView>) {
    }

    func next<SquareView>(piece nextPiece: Piece<SquareView>) {
        wm.redrawNextPieceWindow(piece: nextPiece)
    }

    func scoreDidUpdate(newScore: Score) {
        wm.redrawScoreWindow(score: newScore)
    }
    
    func levelChanged(to newLevel: Level) {
        newInterval(level: newLevel)
        wm.redrawLevelWindow(level: newLevel)
    }
}
