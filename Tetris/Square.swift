//
//  Square.swift
//  Tetris
//
//  Created by Christopher Reitz on 03/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

class Square: UIView {

    var currentRow = 0
    var currentCol = 0

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    func isHit(by touch: UITouch) -> Bool {
        return hitTest(touch.location(in: self), with: nil) != nil
    }
}
