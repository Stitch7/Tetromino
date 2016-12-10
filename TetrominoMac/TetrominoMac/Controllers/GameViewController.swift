//
//  GameViewController.swift
//  TetrominoMac
//
//  Created by Christopher Reitz on 03/12/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import AppKit
import TetrominoMacKit

final class GameViewController: NSViewController {

    // MARK: - Properties

    let game: Game<SquareView>
    let userInput: UserInput
    let highscore: Highscore
    let gameOverView = GameOverView()
    var windowController: WindowController?
    var timer: Timer?

    // MARK: - Initializers

    init(game: Game<SquareView>, userInput: UserInput, highscore: Highscore) {
        self.game = game
        self.userInput = userInput
        self.highscore = highscore

        super.init(nibName: nil, bundle: nil)!
        game.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    // MARK: - NSViewController

    override func loadView() {
        view = NSView(frame: NSMakeRect(0, 0, game.board.width, game.board.height))
        view.wantsLayer = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureAppearance()
        configureGameOverView()
    }

    override func viewDidAppear() {
        super.viewDidAppear()

        windowController = view.window?.windowController as? WindowController
        newGame()
    }

    private func configureAppearance() {
//        view.layer?.backgroundColor = NSColor.white.cgColor
    }

    private func configureGameOverView() {
        gameOverView.frame = NSRect(x: 0, y: 0, width: game.board.width, height: game.board.height)
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
        game.tick()
    }

    func newGame() {
        game.new()
        levelChanged(to: game.level)
        windowController?.score = game.score
        windowController?.highscore = highscore
        gameOverView.isHidden = true
    }
}

// MARK: - GameDelegate

extension GameViewController: GameDelegate {
    func gameOver() {
        disableInterval()

        _ = highscore.save(value: game.score.value)
        gameOverView.removeFromSuperview()
        view.addSubview(gameOverView, positioned: .above, relativeTo: nil)
        gameOverView.isHidden = false
    }

    func display<SquareView>(piece: Piece<SquareView>) {
        for square in piece.squares {
            view.addSubview(square.view as! NSView)
        }
    }

    func remove<SquareView>(piece: Piece<SquareView>) {
        for square in piece.squares {
            square.remove()
        }
    }

    func next<SquareView>(piece nextPiece: Piece<SquareView>) {
        windowController?.nextPieceToolbarItem.image = NSImage(named: nextPiece.type.rawValue)!
    }

    func scoreDidUpdate(newScore: Score) {
        windowController?.score = newScore
    }

    func levelChanged(to newLevel: Level) {
        newInterval(level: newLevel)
        windowController?.level = newLevel
    }
}
