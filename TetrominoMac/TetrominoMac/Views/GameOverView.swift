//
//  GameOverView.swift
//  TetrominoMac
//
//  Created by Christopher Reitz on 04/12/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import Cocoa

class GameOverView: NSVisualEffectView {

    var gameOverTextField: NSTextField = {
        let textField = NSTextField(frame: CGRect(x: 30, y: 500, width: 400, height: 70))
//        textField.translatesAutoresizingMaskIntoConstraints = true
        textField.isBezeled = false
        textField.isEditable = false
        textField.drawsBackground = false
        textField.stringValue = "GAME OVER"
        textField.font = NSFont.systemFont(ofSize: 64, weight: NSFontWeightUltraLight)
        textField.alignment = .center
        return textField
    }()

    var newGameButton: NSButton = {
        let button = NSButton(frame: CGRect(x: 175, y: 440, width: 130, height: 35))
//        button.translatesAutoresizingMaskIntoConstraints = false
        button.bezelStyle = .rounded
        button.title = "New Game"
        button.font = NSFont.systemFont(ofSize: 17)
        return button
    }()

    var newHighScore = false {
        didSet {
            // TODO: launch the rocket
        }
    }

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)

        configure()
        configureSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    private func configure() {
//        translatesAutoresizingMaskIntoConstraints = false
        isHidden = true
        wantsLayer = true
        blendingMode = .withinWindow
        material = .light
        state = .active
    }

    private func configureSubviews() {
        addSubview(gameOverTextField)
        addSubview(newGameButton)

//        let views: [String : Any] = [
//            "gameOverTextField": gameOverTextField,
////            "newGameButton": newGameButton
//        ]
//
//        addConstraints(format: "V:|-[gameOverTextField]", views: views)
//        addConstraints(format: "H:|-[gameOverTextField]", views: views)

//        let horozontalConstraints1: [NSLayoutConstraint] =
//            NSLayoutConstraint.constraints(
//                withVisualFormat: "H:|[gameOverTextField]|",
//                options: .alignAllTop,
//                metrics: nil,
//                views: variableBindings
//        )
//        
//        addConstraints(horozontalConstraints1)
//
//        let horozontalConstraints2: [NSLayoutConstraint] =
//            NSLayoutConstraint.constraints(
//                withVisualFormat: "H:|[newGameButton]|",
//                options: .alignAllTop,
//                metrics: nil,
//                views: variableBindings
//        )
//        addConstraints(horozontalConstraints2)
//
//        let verticalConstraints: [NSLayoutConstraint] =
//            NSLayoutConstraint.constraints(
//                withVisualFormat: "V:[gameOverTextField]-5-[newGameButton]",
//                options: .alignAllTop,
//                metrics: nil,
//                views: variableBindings
//            )
//
//        addConstraints(verticalConstraints)

//        addVerticallyCenteredConstraints(forView: gameOverTextField, inSuperView: self)
//        addConstraints(format: "V:[gameOverTextField]-5-[newGameButton]", views: views)
//        addHorizontallyCenteredConstraints(forView: gameOverTextField, inSuperView: self)
//        addHorizontallyCenteredConstraints(forView: newGameButton, inSuperView: self)
    }
}
