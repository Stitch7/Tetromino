//
//  NextPieceView.swift
//  Tetris
//
//  Created by Christopher Reitz on 13/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

class NextPieceView: UIView {

    // MARK: - Properties

    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Next"
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightLight)
        label.textAlignment = .center
        return label
    }()

    var imageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "L")!)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)

        configure()
        configureLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureLabel() {
        addSubview(label)
        addSubview(imageView)

        let views: [String: Any] =  ["label": label, "imageView": imageView]
        addConstraints(format: "V:|[label]-5-[imageView]|", views: views)
        addConstraints(format: "H:|[label]|", views: views)
        addConstraints(format: "H:|[imageView]|", views: views)
    }
}
