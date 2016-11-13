//
//  GameViewController.swift
//  Tetris
//
//  Created by Christopher Reitz on 02/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {

    // MARK: - Properties

    var board = Board()
    let interval: TimeInterval = 0.1
    var timer: Timer?
    var currentPiece: Piece!
    var audioPlayer = AVAudioPlayer()

    var gameOver = false {
        didSet {
            if gameOver {
                view.bringSubview(toFront: gameOverView)
                gameOverView.isHidden = false
            }
        }
    }
    let gameOverView = GameOverView()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        configureApperance()
        configureGameOverView()
//        configureAudioPlayer()

        timer = Timer.scheduledTimer(
            timeInterval: interval,
            target: self,
            selector: #selector(mainLoop),
            userInfo: nil,
            repeats: true
        )
    }

    private func configureApperance() { 
        view.backgroundColor = .white
    }

    private func configureGameOverView() {
        view.addSubview(gameOverView)
        let views =  ["gameOverView": gameOverView]
        addConstraints(format: "V:|[gameOverView]|", views: views)
        addConstraints(format: "H:|[gameOverView]|", views: views)
    }

    func configureAudioPlayer() {
        do {
            let file = URL(fileURLWithPath: Bundle.main.path(forResource: "djrush", ofType: "mp3")!)
            audioPlayer = try AVAudioPlayer(contentsOf: file)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch {
            print("")
        }
    }

    // MARK: - Main Loop

    func mainLoop(timer: Timer) {
        if currentPiece == nil {
            currentPiece = L.random()
            currentPiece.build()
            for square in currentPiece.squares {
                view.addSubview(square)
            }

            if board.intersectsBottom(with: currentPiece) {
                timer.invalidate()
                gameOver = true
            }
        }
        else if board.intersectsBottom(with: currentPiece) {
            board.add(piece: currentPiece)
            board.killCompletedRows()
            currentPiece = nil
        }
        else {
            currentPiece.moveDown()
        }
    }
}

// MARK: - User Input

extension GameViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard !gameOver, currentPiece != nil else { return false }

        switch gestureRecognizer {
        case _ as UITapGestureRecognizer:       handleTabGestures(with: touch)
        case _ as UILongPressGestureRecognizer: handleLongPressGestures(with: touch)
        default: break
        }

        return false
    }

    func handleTabGestures(with touch: UITouch) {
        let touchLocation = touch.location(in: view)
        let screenCentre = UIScreen.main.bounds.width / 2.0

        if currentPiece.isHit(by: touch) {
            let rotatedPiece = currentPiece.rotated
            if board.intersects(with: rotatedPiece) == false {
                for square in currentPiece.squares {
                    square.removeFromSuperview()
                }
                currentPiece = rotatedPiece
                for square in currentPiece.squares {
                    view.addSubview(square)
                }
            }
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
    }

    func handleLongPressGestures(with touch: UITouch) {
        if currentPiece.isHit(by: touch) {
            currentPiece.fallDown()
        }
    }
}
