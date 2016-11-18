//
//  TouchUserInput.swift
//  Tetris
//
//  Created by Christopher Reitz on 17/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit.UIGestureRecognizer

final class TouchUserInput: NSObject, UserInput, UIGestureRecognizerDelegate {

    // MARK: - Properties

    var view: UIView?

    // MARK: - UserInput

    var piece: Piece?
    var delegate: UserInputDelegate?

    // MARK: - UIGestureRecognizerDelegate

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        handleTabGestures(with: touch)
        return false
    }

    private func handleTabGestures(with touch: UITouch) {
        let touchLocation = touch.location(in: view)

        if pieceIsHit(by: touch) {
            delegate?.rotate()
        }
        else if touchLocation.y > bottomOfScreen() {
            delegate?.moveDown()
        }
        else if touchLocation.x > centerOfCurrentPiece() {
            delegate?.moveRight()
        }
        else {
            delegate?.moveLeft()
        }
    }

    private func pieceIsHit(by touch: UITouch) -> Bool {
        guard let piece = self.piece else { return false }
        for square in piece.squares {
            if square.isHit(by: touch) {
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
