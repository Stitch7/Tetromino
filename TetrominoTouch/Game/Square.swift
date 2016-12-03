//
//  Square.swift
//  TetrominoTouch
//
//  Created by Christopher Reitz on 03/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

final class Square: UIView {

    // MARK: - Properties

    var row = 0
    var col = 0

    // MARK: - Initializers

    init(row: Int, col: Int, frame: CGRect = .zero) {
        self.row = row
        self.col = col
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: - Public

    func isHit(by gesture: UITapGestureRecognizer) -> Bool {
        return hitTest(gesture.location(in: self), with: nil) != nil
    }

    func moveDown() {
        row += 1
        var newFrame = frame
        newFrame.origin.y = newFrame.origin.y + newFrame.size.height
        frame = newFrame
    }
}
