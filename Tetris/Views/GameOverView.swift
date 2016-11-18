//
//  GameOverView.swift
//  Tetris
//
//  Created by Christopher Reitz on 13/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

class GameOverView: UIVisualEffectView {

    // MARK: - Properties

    var gameOverLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "GAME OVER"
        label.font = UIFont.systemFont(ofSize: 44, weight: UIFontWeightUltraLight)
        label.textAlignment = .center
        return label
    }()

    var newGameButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("New Game", for: .normal)
        return button
    }()

    var newHighScore = false {
        didSet {

        }
    }

    // MARK: - Initializers

    init() {
        super.init(effect: UIBlurEffect(style: .light))

        configure()
        configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        isHidden = true
    }

    private func configureSubviews() {
        let vibrancyView = UIVisualEffectView(effect: effect)
        vibrancyView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vibrancyView)
        let vibrancyViews =  ["vibrancyView": vibrancyView]
        contentView.addConstraints(format: "V:|[vibrancyView]|", views: vibrancyViews)
        contentView.addConstraints(format: "H:|[vibrancyView]|", views: vibrancyViews)

        let vibrancyContentView = vibrancyView.contentView
        vibrancyContentView.addSubview(gameOverLabel)
        vibrancyContentView.addSubview(newGameButton)

        let vibrancySubViews: [String: Any] = [
            "gameOverLabel": gameOverLabel,
            "newGameButton": newGameButton
        ]
        vibrancyContentView.addVerticallyCenteredConstraints(forView: gameOverLabel, inSuperView: vibrancyContentView)
        vibrancyContentView.addConstraints(format: "V:[gameOverLabel]-5-[newGameButton]", views: vibrancySubViews)
        vibrancyContentView.addHorizontallyCenteredConstraints(forView: gameOverLabel, inSuperView: vibrancyContentView)
        vibrancyContentView.addHorizontallyCenteredConstraints(forView: newGameButton, inSuperView: vibrancyContentView)
    }
}
