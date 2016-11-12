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
    let interval: TimeInterval = 0.3
    var timer: Timer?
    var currentPiece: Piece!
    var screenCentre = UIScreen.main.bounds.width / 2.0
    var audioPlayer = AVAudioPlayer()

    var gameOverLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "GAME OVER"
        label.font = UIFont.boldSystemFont(ofSize: 44.0)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        configureApperance()
        configureGameOverLabel()
        configureAudioPlayer()
        
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

    private func configureGameOverLabel() {
        view.addSubview(gameOverLabel)

        let views =  ["gameOverLabel": gameOverLabel]
        addConstraints(format: "V:|[gameOverLabel]|", views: views)
        addConstraints(format: "H:|[gameOverLabel]|", views: views)
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
            currentPiece.add(to: view)

            if board.intersectsBottom(with: currentPiece) {
                timer.invalidate()
                view.bringSubview(toFront: gameOverLabel)
                gameOverLabel.isHidden = false
            }
        }
        else if board.intersectsBottom(with: currentPiece) {
            board.add(piece: currentPiece)
            board.killRows()
            currentPiece = nil
        }
        else {
            currentPiece.moveDown()
        }
    }
}

// MARK: - UIGestureRecognizerDelegate

extension GameViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard currentPiece != nil else { return false }

        let touchLocation = touch.location(in: view)
        switch gestureRecognizer {
        case _ as UILongPressGestureRecognizer:
            if currentPiece.isHit(by: touch) {
                currentPiece.fallDown()
            }
        case _ as UITapGestureRecognizer:
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
        default: break
        }

        return false
    }
}
