//
//  Game.swift
//  Tetromino
//
//  Created by Christopher Reitz on 15/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

protocol GameDelegate {
    func gameOver()
    func display(piece: Piece)
    func remove(piece: Piece)
    func next(piece nextPiece: Piece)
    func scoreDidUpdate(newScore: Score)
    func levelChanged(to newLevel: Level)
}

final class Game {

    // MARK: - Properties

    var board: Board
    var userInput: UserInput {
        didSet {
            userInput.userInputDelegate = self
        }
    }
    var score: Score
    var nextPiece: Piece
    var delegate: GameDelegate?

    var level: Level {
        willSet {
            if level != newValue {
                delegate?.levelChanged(to: newValue)
            }
        }
    }

    fileprivate var currentPiece: Piece? {
        didSet {
            userInput.piece = currentPiece
        }
    }

    var gameOver = false {
        didSet {
            if gameOver {
                delegate?.gameOver()
            }
        }
    }

    // MARK: - Initializers

    init(board: Board, userInput: UserInput, score: Score = 0, level: Level = .one) {
        self.board = board
        self.userInput = userInput
        self.score = score
        self.level = level
        self.nextPiece = PieceFactory.random()
    }

    // MARK: - Public

    func new() {
        board.reset()
        level = .one
        score = 0
        gameOver = false
    }

    func tick() {
        if gameOver { return }

        if currentPiece == nil {
            spawnNewPiece()
            return
        }

        if board.intersectsBottom(with: currentPiece) {
            landPiece()
            return
        }

        currentPiece?.moveDown()
    }

    // MARK: - Private

    private func spawnNewPiece() {
        nextPiece.build(width: board.squareWidth, height: board.squareHeight)
        delegate?.display(piece: nextPiece)
        currentPiece = nextPiece

        if board.intersectsBottom(with: currentPiece) {
            gameOver = true
        }
        else {
            nextPiece = PieceFactory.random()
            delegate?.next(piece: nextPiece)
        }
    }

    private func landPiece() {
        guard let currentPiece = self.currentPiece else { return }

        board.add(piece: currentPiece)
        let killedRows = board.killCompletedRows()
        score.add(numberOfRows: killedRows, level: level)
        updateLevel()
        delegate?.scoreDidUpdate(newScore: score)
        self.currentPiece = nil
    }

    private func updateLevel() {
        var newLevel: Level?
        if score.rowsCompleted >= 91 {
            newLevel = .nine
        }
        else if score.rowsCompleted >= 1 {
            newLevel = Level(rawValue: 1 + ((score.rowsCompleted - 1) / 10))
        }

        if let level = newLevel {
            self.level = level
        }
    }
}

// MARK: - UserInputDelegate

extension Game: UserInputDelegate {
    func rotate() {
        guard let currentPiece = self.currentPiece else { return }

        let rotatedPiece = currentPiece.rotated
        if board.intersects(with: rotatedPiece) == false {
            delegate?.remove(piece: currentPiece)
            delegate?.display(piece: rotatedPiece)
            self.currentPiece = rotatedPiece
        }
    }

    func moveLeft() {
        if board.intersectsLeft(with: currentPiece) == false {
            currentPiece?.moveLeft()
        }
    }

    func moveRight() {
        if board.intersectsRight(with: currentPiece) == false {
            currentPiece?.moveRight()
        }
    }

    func moveDown() {
        if board.intersectsBottom(with: currentPiece) == false {
            currentPiece?.moveDown()
        }
    }

    func dropDown() {
        guard let currentPiece = self.currentPiece else { return }

        let piece = currentPiece
        while board.intersectsBottom(with: piece) == false {
            self.currentPiece?.moveDown()
        }

        delegate?.remove(piece: currentPiece)
        delegate?.display(piece: piece)
        self.currentPiece = piece
    }
}
