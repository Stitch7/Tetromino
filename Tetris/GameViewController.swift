//
//  GameViewController.swift
//  Tetris
//
//  Created by Christopher Reitz on 02/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    // MARK: - Properties

    var board = Board()
    let interval: TimeInterval = 1.0
    var timer: Timer?
    var currentPiece: Tetrimino!
    let screenHeight = UIScreen.main.bounds.height
    var screenCentre = UIScreen.main.bounds.width / 2.0

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        timer = Timer.scheduledTimer(
            timeInterval: interval,
            target: self,
            selector: #selector(mainLoop),
            userInfo: nil,
            repeats: true
        )
    }

    // MARK: - Main Loop

    func mainLoop() {
        if currentPiece == nil {
            currentPiece = L()
            currentPiece.add(to: view)
        }

        for square in currentPiece.squares {
            if (square.frame.origin.y + edgeLength) > screenHeight {
                board.add(piece: currentPiece)
                currentPiece = nil
                return
            }
        }

        currentPiece.moveDone()
    }
}

// MARK: - UIGestureRecognizerDelegate

extension GameViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard currentPiece != nil else { return false }

        let touchLocation = touch.location(in: view)

        if currentPiece.isHit(by: touch) {
            currentPiece.rotate(in: view)
        }
        else if touchLocation.x > screenCentre {
            if board.intersectsRight(with: currentPiece) == false {
                currentPiece.moveRight()
            }
        }
        else {
            if board.intersectsLeft(with: currentPiece) == false {
                currentPiece.moveLeft()
            }
        }

        return false
    }
}
