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

    let imageView: UIImageView

    var image: UIImage? {
        didSet {
            self.imageView.image = image
        }
    }
    
    var piece: Piece {
        didSet {
            switch piece {
            case _ as I: self.image = UIImage(named: "I")!
            case _ as J: self.image = UIImage(named: "J")!
            case _ as L: self.image = UIImage(named: "L")!
            case _ as O: self.image = UIImage(named: "O")!
            case _ as S: self.image = UIImage(named: "S")!
            case _ as T: self.image = UIImage(named: "T")!
            case _ as Z: self.image = UIImage(named: "Z")!
            default: break
            }
        }
    }

    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Next"
        label.font = UIFont.systemFont(ofSize: 10.0, weight: UIFontWeightLight)
        label.textAlignment = .center
        return label
    }()

    // MARK: - Initializers

    init(piece: Piece) {
        self.imageView = UIImageView(image: nil)
        self.piece = piece
        super.init(frame: .zero)

        configureLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    private func configureLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(label)
        addSubview(imageView)

        let views: [String: Any] =  ["label": label, "imageView": imageView]
        addConstraints(format: "V:|[label(10)]-2-[imageView]|", views: views)
        addConstraints(format: "H:|[label(30)]|", views: views)
        addHorizontallyCenteredConstraints(forView: imageView, inSuperView: self)
    }
}
