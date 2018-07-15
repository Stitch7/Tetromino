//
//  LevelView.swift
//  TetrominoTouchKit
//
//  Created by Christopher Reitz on 13/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

class LevelView: UIView {

    // MARK: - Properties

    var level: Level = .one {
        didSet {
            value.text = "\(level.number)"
        }
    }

    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Level"
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .light)

        return label
    }()

    var value: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .light)

        return label
    }()

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
        translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureSubviews() {
        addSubview(label)
        addSubview(value)

        let views: [String: Any]  =  ["label": label, "value": value]
        addConstraints(format: "V:|[label]|", views: views)
        addConstraints(format: "V:|[value]|", views: views)
        addConstraints(format: "H:|[label]-5-[value]|", views: views)
    }
}
