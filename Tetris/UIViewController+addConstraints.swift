//
//  UIViewController+addConstraints.swift
//  Tetris
//
//  Created by Christopher Reitz on 05/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

extension UIViewController {
    func addConstraints(format: String, views: [String : Any]) {
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format,
                                                           options: [],
                                                           metrics: nil,
                                                           views: views))
    }
}
