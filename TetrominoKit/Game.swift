//
//  Game.swift
//  TetrominoKit
//
//  Created by Christopher Reitz on 15/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

public protocol GameDelegate {
    func display<ViewType: SquareViewType>(piece: Piece<ViewType>)
    func remove<ViewType: SquareViewType>(piece: Piece<ViewType>)
    func next<ViewType: SquareViewType>(piece nextPiece: Piece<ViewType>)
    func scoreDidUpdate(newScore: Score)
    func levelChanged(to newLevel: Level)
    func newGame()
//    func pauseGame()
    func gameOver()
}

public final class Game<ViewType: SquareViewType> {

    // MARK: - Properties

    public var board: Board<ViewType>
    public var score: Score
    public var nextPiece: Piece<ViewType>
    public var delegate: GameDelegate?

    public var level: Level {
        willSet {
            if level != newValue {
                delegate?.levelChanged(to: newValue)
            }
        }
    }

    public var gameOver = false {
        didSet {
            if gameOver {
                delegate?.gameOver()
            }
        }
    }

    public var currentPiece: Piece<ViewType>?

    // MARK: - Initializers

    public init(board: Board<ViewType>, score: Score = 0, level: Level = .one) {
        self.board = board
        self.score = score
        self.level = level
        self.nextPiece = PieceType.random()
    }

    // MARK: - Public

    public func new() {
        board.reset()
        level = .one
        delegate?.levelChanged(to: level)
        score = 0
        delegate?.scoreDidUpdate(newScore: score)
        gameOver = false
    }

    public func tick() {
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
            landPiece()
            gameOver = true
        }
        else {
            nextPiece = PieceType.random()
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

    public func newGame() {
        delegate?.newGame()
    }

//    public func pause() {
////        delegate?.pauseGame()
//    }

    public func rotate() {
        guard let currentPiece = self.currentPiece else { return }

        let rotatedPiece = currentPiece.rotated
        if board.intersects(with: rotatedPiece) == false {
            delegate?.remove(piece: currentPiece)
            delegate?.display(piece: rotatedPiece)
            self.currentPiece = rotatedPiece
        }
    }

    public func moveLeft() {
        if board.intersectsLeft(with: currentPiece) == false {
            currentPiece?.moveLeft()
        }
    }

    public func moveRight() {
        if board.intersectsRight(with: currentPiece) == false {
            currentPiece?.moveRight()
        }
    }

    public func moveDown() {
        if board.intersectsBottom(with: currentPiece) == false {
            currentPiece?.moveDown()
        }
    }

    public func dropDown() {
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
