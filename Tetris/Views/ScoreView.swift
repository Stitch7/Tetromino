//
//  ScoreView.swift
//  Tetris
//
//  Created by Christopher Reitz on 13/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

class ScoreView: UIView {

    // MARK: - Properties

    var score: Score {
        didSet {
            value.text = "\(score.value)"
        }
    }

    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Score"
        label.font = UIFont.systemFont(ofSize: 22.0, weight: UIFontWeightThin)
        return label
    }()

    var value: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 22.0, weight: UIFontWeightThin)
        return label
    }()

    var highscoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Highscore"
        label.font = UIFont.systemFont(ofSize: 9.0, weight: UIFontWeightLight)
        return label
    }()

    var highscoreValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "42000"
        label.font = UIFont.systemFont(ofSize: 9.0, weight: UIFontWeightRegular)
        return label
    }()

    // MARK: - Initializers

    init(score: Score) {
        self.score = score
        super.init(frame: CGRect(x: 0, y: 0, width: 70, height: 44.0))

        configureSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    private func configureSubviews() {
        addSubview(label)
        addSubview(value)
        addSubview(highscoreLabel)
        addSubview(highscoreValue)

        let views: [String: Any]  =  [
            "label": label,
            "value": value,
            "highscoreLabel": highscoreLabel,
            "highscoreValue": highscoreValue
        ]
        addConstraints(format: "V:|[label][highscoreLabel]", views: views)
        addConstraints(format: "V:|[label][highscoreValue]", views: views)
        addConstraints(format: "V:|[value]", views: views)
        addConstraints(format: "H:|[label]-5-[value]", views: views)
        addConstraints(format: "H:|[highscoreLabel]-2-[highscoreValue]", views: views)
    }
}
