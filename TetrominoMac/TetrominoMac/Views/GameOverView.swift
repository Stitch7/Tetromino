//
//  GameOverView.swift
//  TetrominoMac
//
//  Created by Christopher Reitz on 04/12/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import AppKit

class GameOverView: NSVisualEffectView {

    var gameOverTextField: NSTextField = {
        let textField = NSTextField(frame: CGRect(x: 30, y: 500, width: 400, height: 70))
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
        isHidden = true
        wantsLayer = true
        blendingMode = .withinWindow
        material = .light
        state = .active
    }

    private func configureSubviews() {
        addSubview(gameOverTextField)
        addSubview(newGameButton)
    }
}
