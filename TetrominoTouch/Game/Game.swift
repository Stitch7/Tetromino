//
//  Game.swift
//  TetrominoTouch
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
}

final class Game {

    // MARK: - Properties

    var board: Board
    var userInput: UserInput
    var score: Score
    var level: Level
    var nextPiece: Piece
    var delegate: GameDelegate?

    var currentPiece: Piece? {
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

    init(board: Board, userInput: UserInput, score: Score, level: Level = .one) {
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
        score.add(numberOfRows: killedRows)
        delegate?.scoreDidUpdate(newScore: score)
        self.currentPiece = nil
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
}
