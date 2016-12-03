//
//  ScoreView.swift
//  TetrominoTouch
//
//  Created by Christopher Reitz on 13/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

class ScoreView: UIView {

    // MARK: - Properties

    var score: Score {
        didSet {
            let labelText = NSMutableAttributedString(
                string: "Score",
                attributes: [
                    NSFontAttributeName: label.font
                ]
            )
            let valueText = NSAttributedString(
                string: " \(score.value)",
                attributes: [
                    NSFontAttributeName: UIFont.systemFont(ofSize: label.font.pointSize, weight: UIFontWeightThin)
                ]
            )
            labelText.append(valueText)

            label.attributedText = labelText
        }
    }

    var highscore: Highscore {
        didSet {
            let labelText = NSMutableAttributedString(
                string: "Highscore",
                attributes: [
                    NSFontAttributeName: highscoreLabel.font
                ]
            )
            let valueText = NSAttributedString(
                string: " \(highscore.leader)",
                attributes: [
                    NSFontAttributeName: UIFont.systemFont(ofSize: highscoreLabel.font.pointSize, weight: UIFontWeightRegular)
                ]
            )
            labelText.append(valueText)

            highscoreLabel.attributedText = labelText
        }
    }

    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Score"
        label.font = UIFont.systemFont(ofSize: 22.0, weight: UIFontWeightThin)
        label.textAlignment = .center
        return label
    }()

    var highscoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Highscore"
        label.font = UIFont.systemFont(ofSize: 9.0, weight: UIFontWeightLight)
        label.textAlignment = .center
        return label
    }()

    // MARK: - Initializers

    init(score: Score, highscore: Highscore) {
        self.score = score
        self.highscore = highscore
        super.init(frame: CGRect(x: 0, y: 0, width: 70, height: 44.0))

        configureSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    private func configureSubviews() {
        addSubview(label)
        addSubview(highscoreLabel)

        let views: [String: Any]  =  [
            "label": label,
            "highscoreLabel": highscoreLabel
        ]
        addConstraints(format: "V:|[label][highscoreLabel]", views: views)
        addHorizontallyCenteredConstraints(forView: label, inSuperView: self)
        addHorizontallyCenteredConstraints(forView: highscoreLabel, inSuperView: self)
    }
}
