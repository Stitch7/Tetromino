//
//  NextPieceView.swift
//  TetrominoTouchKit
//
//  Created by Christopher Reitz on 13/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

class NextPieceView: UIView {

    // MARK: - Properties

    let imageView: UIImageView

    var image: UIImage? {
        didSet {
            self.imageView.image = image
        }
    }

    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Next"
        label.font = UIFont.systemFont(ofSize: 10.0, weight: .light)
        label.textAlignment = .center
        return label
    }()

    // MARK: - Initializers

    init() {
        self.imageView = UIImageView(image: nil)
        super.init(frame: .zero)

        configureSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    private func configureSubviews() {
        translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(label)
        addSubview(imageView)

        let views: [String: Any] =  ["label": label, "imageView": imageView]
        addConstraints(format: "V:|[label(10)]-2-[imageView]|", views: views)
        addConstraints(format: "H:|[label(30)]|", views: views)
        imageView.addHorizontallyCenteredConstraints(inSuperView: self)
    }
}
