//
//  GameViewController.swift
//  TetrominoMac
//
//  Created by Christopher Reitz on 03/12/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import Cocoa
import TetrominoCoreMac

class GameViewController: NSViewController {

    var board: Board?
    var game: Game?
    var highscore = Highscore(userDefaults: UserDefaults.standard)
    var windowController: WindowController?
    var gameOverView = GameOverView()

    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureAppearance()
    }

    override func viewDidAppear() {
        super.viewDidAppear()

        let titlebarHeight: CGFloat = 22.0
        board = Board(width: view.window!.frame.width,
                      height: view.window!.frame.height - titlebarHeight)
        game = Game(board: board!, userInput: view.window as! UserInput)
        game?.delegate = self
        windowController = view.window?.windowController as? WindowController

        configureGameOverView()

        newGame()
    }

    private func configureAppearance() {
        view.layer?.backgroundColor = NSColor.white.cgColor
    }

    private func configureGameOverView() {
        gameOverView.frame = NSRect(x: 0, y: 0, width: board!.width, height: board!.height)
        view.addSubview(gameOverView, positioned: .above, relativeTo: nil)

        gameOverView.newGameButton.target = self
        gameOverView.newGameButton.action = #selector(newGame)
    }

    // MARK: - Interval

    func disableInterval() {
        timer?.invalidate()
    }

    func newInterval(level: Level) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            timeInterval: level.speed,
            target: self,
            selector: #selector(interval),
            userInfo: nil,
            repeats: true
        )
    }

    func interval() {
        game?.tick()
    }

    func newGame() {
        game?.new()
        levelChanged(to: game!.level)
        windowController?.score = game?.score
        windowController?.highscore = highscore
        gameOverView.isHidden = true
    }
}

// MARK: - GameDelegate

extension GameViewController: GameDelegate {
    func gameOver() {
        disableInterval()

        _ = highscore.save(value: game!.score.value)
        gameOverView.removeFromSuperview()
        view.addSubview(gameOverView, positioned: .above, relativeTo: nil)
        gameOverView.isHidden = false
    }

    func display(piece: Piece) {
        for square in piece.squares {
            view.addSubview(square)
        }
    }

    func remove(piece: Piece) {
        for square in piece.squares {
            square.removeFromSuperview()
        }
    }

    func next(piece nextPiece: Piece) {
        windowController?.piece = nextPiece
    }

    func scoreDidUpdate(newScore: Score) {
        windowController?.score = newScore
    }

    func levelChanged(to newLevel: Level) {
        newInterval(level: newLevel)
        windowController?.level = newLevel
    }
}
