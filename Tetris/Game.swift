//
//  Game.swift
//  Tetris
//
//  Created by Christopher Reitz on 15/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

protocol GameDelegate {
    func gameOver()
    func mainView() -> UIView
}

final class Game: NSObject, UIGestureRecognizerDelegate {

    // MARK: - Properties

    let score: Score
    var level: Level
    var delegate: GameDelegate?

    private var gameOver = false {
        didSet {
            if gameOver {
                delegate?.gameOver()
            }
        }
    }
    private var board = Board()
    private var currentPiece: Piece!

    // MARK: - Initializers

    init(score: Score, level: Level = .one) {
        self.score = score
        self.level = level
    }

    // MARK: - Public

    func tick() {
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
        currentPiece = PieceFactory.random()
        currentPiece.build()
        for square in currentPiece.squares {
            delegate?.mainView().addSubview(square)
        }

        if board.intersectsBottom(with: currentPiece) {
            gameOver = true
        }
    }

    private func landPiece() {
        board.add(piece: currentPiece)
        let killedRows = board.killCompletedRows()
        score.add(numberOfRows: killedRows)
        currentPiece = nil
    }

    // MARK: - UIGestureRecognizerDelegate

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard !gameOver, currentPiece != nil else { return false }

        return handleTabGestures(with: touch)
    }

    private func handleTabGestures(with touch: UITouch) -> Bool {
        let touchLocation = touch.location(in: delegate?.mainView())

        if currentPieceIsHit(by: touch) {
            let rotatedPiece = currentPiece.rotated
            if board.intersects(with: rotatedPiece) == false {
                rotate(piece: rotatedPiece)
            }
            return false
        }

        if touchLocation.y > bottomOfScreen() &&
            board.intersectsBottom(with: currentPiece) == false {
            currentPiece.moveDown()
            return false
        }

        if touchLocation.x > centerOfCurrentPiece() &&
            board.intersectsRight(with: currentPiece) == false {
            currentPiece.moveRight()
            return false
        }

        if board.intersectsLeft(with: currentPiece) == false {
            currentPiece.moveLeft()
        }
        return false
    }

    private func currentPieceIsHit(by touch: UITouch) -> Bool {
        for square in currentPiece.squares {
            if square.isHit(by: touch) {
                return true
            }
        }
        return false
    }

    private func rotate(piece: Piece) {
        for square in currentPiece.squares {
            square.removeFromSuperview()
        }
        currentPiece = piece
        for square in currentPiece.squares {
            delegate?.mainView().addSubview(square)
        }
    }

    private func bottomOfScreen() -> CGFloat {
        guard let screenHeight = delegate?.mainView().frame.size.height else { return 0 }
        return (screenHeight / 10) * 9.2
    }

    private func centerOfCurrentPiece() -> CGFloat {
        return currentPiece.leftX + ((currentPiece.rightX - currentPiece.leftX) / 2.0)
    }
}
