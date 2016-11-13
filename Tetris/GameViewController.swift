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
    var screenCentre = UIScreen.main.bounds.width / 2.0
    var audioPlayer = AVAudioPlayer()

    var gameOver = false {
        didSet {
            if gameOver {
                view.bringSubview(toFront: gameOverView)
                gameOverView.isHidden = false
            }
        }
    }

    var gameOverView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()

    var gameOverLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "GAME OVER"
        label.font = UIFont.systemFont(ofSize: 44, weight: UIFontWeightUltraLight)
        label.textAlignment = .center
        return label
    }()

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

        let vibrancyView = UIVisualEffectView(effect: gameOverView.effect)
        vibrancyView.translatesAutoresizingMaskIntoConstraints = false
        gameOverView.contentView.addSubview(vibrancyView)
        let vibrancyViews =  ["vibrancyView": vibrancyView]
        gameOverView.contentView.addConstraints(format: "V:|[vibrancyView]|", views: vibrancyViews)
        gameOverView.contentView.addConstraints(format: "H:|[vibrancyView]|", views: vibrancyViews)

        vibrancyView.contentView.addSubview(gameOverLabel)
        let vibrancySubViews =  ["gameOverLabel": gameOverLabel]
        vibrancyView.contentView.addConstraints(format: "V:|[gameOverLabel]|", views: vibrancySubViews)
        vibrancyView.contentView.addConstraints(format: "H:|[gameOverLabel]|", views: vibrancySubViews)
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
        guard currentPiece != nil else { return false }

        let touchLocation = touch.location(in: view)
        switch gestureRecognizer {
        case _ as UILongPressGestureRecognizer:
            if currentPiece.isHit(by: touch) {
                currentPiece.fallDown()
            }
        case _ as UITapGestureRecognizer:
            if gameOver { return false }

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
