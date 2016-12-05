//
//  TouchUserInput.swift
//  TetrominoTouch
//
//  Created by Christopher Reitz on 17/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit
import TetrominoCoreIOS

final class TouchUserInput: UserInput {

    // MARK: - Properties

    var view: UIView?
    var squares = [UIView]()

    // MARK: - UserInput

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
        for square in squares {
            if (square as! SquareView).isHit(by: gesture) {
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
        let leftSquare = squares.map({ $0 as! SquareView }).sorted(by: { $0.col < $1.col }).first!
        let leftX = leftSquare.frame.origin.x

        let rightSquare = squares.map({ $0 as! SquareView }).sorted(by: { $0.col < $1.col }).last!
        let rightX = rightSquare.frame.origin.x + rightSquare.frame.size.width

        return leftX + ((rightX - leftX) / 2.0)
    }
}
