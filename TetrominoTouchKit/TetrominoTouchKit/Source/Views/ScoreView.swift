//
//  ScoreView.swift
//  TetrominoTouchKit
//
//  Created by Christopher Reitz on 13/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

class ScoreView: UIView {

    // MARK: - Properties

    var score: Score {
        didSet {
            let labelFont = label.font!
            let labelText = NSMutableAttributedString(
                string: "Score",
                attributes: [NSAttributedStringKey.font: labelFont]
            )
            let valueFont = UIFont.systemFont(ofSize: label.font.pointSize, weight: .thin)
            let valueText = NSAttributedString (
                string: " \(score.value)",
                attributes: [NSAttributedStringKey.font: valueFont]
            )
            labelText.append(valueText)

            label.attributedText = labelText
        }
    }

    var highscore: Highscore {
        didSet {
            let labelFont = highscoreLabel.font!
            let labelText = NSMutableAttributedString(
                string: "Level 1",
                attributes: [NSAttributedStringKey.font: labelFont]
            )
//            let valueFont = UIFont.systemFont(ofSize: highscoreLabel.font.pointSize, weight: .regular)
//            let valueText = NSAttributedString(
//                string: " \(highscore.leader)",
//                attributes: [NSAttributedStringKey.font: valueFont]
//            )
//            labelText.append(valueText)

            highscoreLabel.attributedText = labelText
        }
    }

    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Score"
        label.font = UIFont.systemFont(ofSize: 28.0, weight: .thin)
        label.textAlignment = .center
        return label
    }()

    var highscoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Highscore"
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .light)
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
        addConstraints(format: "V:[label][highscoreLabel]", views: views)
        label.addHorizontallyCenteredConstraints(inSuperView: self)
        highscoreLabel.addHorizontallyCenteredConstraints(inSuperView: self)
    }
}
