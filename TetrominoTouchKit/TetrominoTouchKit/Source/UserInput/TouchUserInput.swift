//
//  TouchUserInput.swift
//  TetrominoTouchKit
//
//  Created by Christopher Reitz on 17/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

final class TouchUserInput: UserInput {

    // MARK: - Properties

    var view: UIView? {
        didSet {
            configureRotateGesture()
        }
    }
    var squares = [UIView]()

    // MARK: - UserInput

    var userInputDelegate: UserInputDelegate?

    // MARK: - EventHandler

    @objc func handleTabGestures(sender: UITapGestureRecognizer) {
        let touchLocation = sender.location(in: view)

        if pieceIsHit(by: sender) {
            userInputDelegate?.rotateLeft()
        } else if touchLocation.y > bottomOfScreen() {
            userInputDelegate?.moveDown()
        } else if touchLocation.x > centerOfCurrentPiece() {
            userInputDelegate?.moveRight()
        } else {
            userInputDelegate?.moveLeft()
        }
    }

    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        guard sender.state == .ended else { return }

//        if sender.location(in: view).y > bottomOfScreen() {
//            userInputDelegate?.dropDown()
//        }
        userInputDelegate?.dropDown()
    }

    // MARK: - Helper

    private func configureRotateGesture() {
        guard let view = self.view else { return }

        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(viewSwipedLeft(sender:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)

        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(viewSwipedRight(sender:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)

        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(viewSwipedDown(sender:)))
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
    }

    private func pieceIsHit(by gesture: UITapGestureRecognizer) -> Bool {
        for square in squares {
            if (square as! SquareView).isHit(by: gesture) {
                return true
            }
        }
        return false
    }

    @objc private func viewSwipedLeft(sender: Any) {
        userInputDelegate?.moveLeft()
    }

    @objc private func viewSwipedRight(sender: Any) {
        userInputDelegate?.moveRight()
    }

    @objc private func viewSwipedDown(sender: Any) {
        userInputDelegate?.rotateLeft()
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
