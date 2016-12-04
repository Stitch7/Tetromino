//
//  TouchUserInput.swift
//  TetrominoTouch
//
//  Created by Christopher Reitz on 17/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

final class TouchUserInput: UserInput {

    // MARK: - Properties

    var view: UIView?

    // MARK: - UserInput

    var piece: Piece?
    var userInputDelegate: UserInputDelegate?

    // MARK: - EventHandler

    @objc func handleTabGestures(sender: UITapGestureRecognizer) {
        let touchLocation = sender.location(in: view)

        if pieceIsHit(by: sender) {
            userInputDelegate?.rotate()
        }
        else if touchLocation.y > bottomOfScreen() {
            userInputDelegate?.moveDown()
        }
        else if touchLocation.x > centerOfCurrentPiece() {
            userInputDelegate?.moveRight()
        }
        else {
            userInputDelegate?.moveLeft()
        }
    }

    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        guard sender.state == .ended else { return }

        if sender.location(in: view).y > bottomOfScreen() {
            userInputDelegate?.dropDown()
        }
    }

    // MARK: - Helper

    private func pieceIsHit(by gesture: UITapGestureRecognizer) -> Bool {
        guard let piece = self.piece else { return false }
        for square in piece.squares {
            if square.isHit(by: gesture) {
                return true
            }
        }
        return false
    }

    private func bottomOfScreen() -> CGFloat {
        guard let view = self.view else { return 0.0 }
        let screenHeight = view.frame.size.height
        return (screenHeight / 10) * 9.2
    }

    private func centerOfCurrentPiece() -> CGFloat {
        guard let piece = self.piece else { return 0.0 }
        return piece.leftX + ((piece.rightX - piece.leftX) / 2.0)
    }
}
