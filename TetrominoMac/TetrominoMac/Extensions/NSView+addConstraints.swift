//
//  NSView+addConstraints.swift
//  TetrominoTouch
//
//  Created by Christopher Reitz on 04/12/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import AppKit

extension NSView {
    func addConstraints(format: String, views: [String : Any]) {
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: format,
            options: [],
            metrics: nil,
            views: views)
        )
    }

    func addHorizontallyCenteredConstraints(forView view: NSView, inSuperView superView: NSView) {
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[superview]-(<=1)-[view]",
            options: .alignAllCenterX,
            metrics: nil,
            views: ["superview": self, "view": view])
        )
    }

    func addVerticallyCenteredConstraints(forView view: NSView, inSuperView superView: NSView) {
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:[superview]-(<=1)-[view]",
            options: .alignAllCenterY,
            metrics: nil,
            views: ["superview": self, "view": view])
        )
    }
}

extension NSViewController {
    func addConstraints(format: String, views: [String : Any]) {
        view.addConstraints(format: format, views: views)
    }

    func addHorizontallyCenterConstraints(forView view: NSView, inSuperView superView: NSView) {
        view.addHorizontallyCenteredConstraints(forView: view, inSuperView: superView)
    }

    func addVerticallyCenteredConstraints(forView view: NSView, inSuperView superView: NSView) {
        view.addVerticallyCenteredConstraints(forView: view, inSuperView: superView)
    }
}
