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

    var newHighScore = false {
        didSet {

        }
    }

    // MARK: - Initializers

    init() {
        super.init(effect: UIBlurEffect(style: .light))

        configure()
        configureGameOverLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        isHidden = true
    }

    private func configureGameOverLabel() {
        let vibrancyView = UIVisualEffectView(effect: effect)
        vibrancyView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vibrancyView)
        let vibrancyViews =  ["vibrancyView": vibrancyView]
        contentView.addConstraints(format: "V:|[vibrancyView]|", views: vibrancyViews)
        contentView.addConstraints(format: "H:|[vibrancyView]|", views: vibrancyViews)

        vibrancyView.contentView.addSubview(gameOverLabel)
        let vibrancySubViews =  ["gameOverLabel": gameOverLabel]
        vibrancyView.contentView.addConstraints(format: "V:|[gameOverLabel]|", views: vibrancySubViews)
        vibrancyView.contentView.addConstraints(format: "H:|[gameOverLabel]|", views: vibrancySubViews)
    }
}
