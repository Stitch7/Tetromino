//
//  NextPieceView.swift
//  TetrominoTouch
//
//  Created by Christopher Reitz on 13/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit
import TetrominoCoreIOS

class NextPieceView: UIView {

    // MARK: - Properties

    let imageView: UIImageView

    var image: UIImage? {
        didSet {
            self.imageView.image = image
        }
    }
    
//    var piece: Piece<SquareView> {
//        didSet {
//            switch piece {
//            case _ as I<SquareView>: self.image = UIImage(named: "I")!
//            case _ as J<SquareView>: self.image = UIImage(named: "J")!
//            case _ as L<SquareView>: self.image = UIImage(named: "L")!
//            case _ as O<SquareView>: self.image = UIImage(named: "O")!
//            case _ as S<SquareView>: self.image = UIImage(named: "S")!
//            case _ as T<SquareView>: self.image = UIImage(named: "T")!
//            case _ as Z<SquareView>: self.image = UIImage(named: "Z")!
//            default: break
//            }
//        }
//    }

    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Next"
        label.font = UIFont.systemFont(ofSize: 10.0, weight: UIFontWeightLight)
        label.textAlignment = .center
        return label
    }()

    // MARK: - Initializers

//    init(piece: Piece<SquareView>) {
    init() {
        self.imageView = UIImageView(image: nil)
//        self.piece = piece
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
        addHorizontallyCenteredConstraints(forView: imageView, inSuperView: self)
    }
}
