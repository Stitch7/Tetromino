//
//  Game.swift
//  Tetris
//
//  Created by Christopher Reitz on 15/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

protocol GameDelegate {
    func gameOver()
    func display(piece: Piece)
    func remove(piece: Piece)
    func next(piece nextPiece: Piece)
}

final class Game {

    // MARK: - Properties

    var userInput: UserInput
    let score: Score
    var level: Level
    var delegate: GameDelegate?
    var board = Board()
    var nextPiece: Piece
    var currentPiece: Piece! {
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

    init(userInput: UserInput, score: Score, level: Level = .one) {
        self.userInput = userInput
        self.score = score
        self.level = level
        self.nextPiece = PieceFactory.random()
    }

    // MARK: - Public

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

        currentPiece.moveDown()
    }

    // MARK: - Private

    private func spawnNewPiece() {
        currentPiece = nextPiece
        currentPiece.build()
        delegate?.display(piece: currentPiece)

        if board.intersectsBottom(with: currentPiece) {
            gameOver = true
        }
        else {
            nextPiece = PieceFactory.random()
            delegate?.next(piece: nextPiece)
        }
    }

    private func landPiece() {
        board.add(piece: currentPiece)
        let killedRows = board.killCompletedRows()
        score.add(numberOfRows: killedRows)
        currentPiece = nil
    }
}

// MARK: - UserInputDelegate

extension Game: UserInputDelegate {
    func rotate() {
        let rotatedPiece = currentPiece.rotated
        if board.intersects(with: rotatedPiece) == false {
            delegate?.remove(piece: currentPiece)
            delegate?.display(piece: rotatedPiece)
            currentPiece = rotatedPiece
        }
    }

    func moveLeft() {
        if board.intersectsLeft(with: currentPiece) == false {
            currentPiece.moveLeft()
        }
    }

    func moveRight() {
        if board.intersectsRight(with: currentPiece) == false {
            currentPiece.moveRight()
        }
    }

    func moveDown() {
        if board.intersectsBottom(with: currentPiece) == false {
            currentPiece.moveDown()
        }
    }
}
