//
//  UIView+addConstraints.swift
//  TetrominoTouch
//
//  Created by Christopher Reitz on 05/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraints(format: String, views: [String : Any]) {
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format,
                                                      options: [],
                                                      metrics: nil,
                                                      views: views))
    }

    func addHorizontallyCenteredConstraints(inSuperView superView: UIView) {
//        let constraints = NSLayoutConstraint.constraints(
//            withVisualFormat: "V:[superview]-(<=1)-[view]",
//            options: .alignAllCenterX,
//            metrics: nil,
//            views: ["superview": self, "view": view]
//        )
//
//        addConstraints(constraints)

        superView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    func addVerticallyCenteredConstraints(inSuperView superView: UIView) {
//        let constraints = NSLayoutConstraint.constraints(
//            withVisualFormat: "H:[superview]-(<=1)-[view]",
//            options: .alignAllCenterY,
//            metrics: nil,
//            views: ["superview": self, "view": view]
//        )
//
//        addConstraints(constraints)

        superView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}

extension UIViewController {
    func addConstraints(format: String, views: [String : Any]) {
        view.addConstraints(format: format, views: views)
    }

    func addHorizontallyCenterConstraints(inSuperView superView: UIView) {
        view.addHorizontallyCenteredConstraints(inSuperView: superView)
    }

    func addVerticallyCenteredConstraints(inSuperView superView: UIView) {
        view.addVerticallyCenteredConstraints(inSuperView: superView)
    }
}
