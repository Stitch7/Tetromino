//
//  Square.swift
//  TetrominoTouch
//
//  Created by Christopher Reitz on 03/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

public class Square: UIView {

    // MARK: - Properties

    public var row = 0
    public var col = 0

    // MARK: - Initializers

    public init(color: Color, row: Int, col: Int, frame: CGRect = .zero) {
        self.row = row
        self.col = col
        
        super.init(frame: frame)

        backgroundColor = color.uiColor
    }

    required public init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: - Public

    public func isHit(by gesture: UITapGestureRecognizer) -> Bool {
        return hitTest(gesture.location(in: self), with: nil) != nil
    }

    func moveLeft() {
        col -= 1
        var newFrame = frame
        newFrame.origin.x = newFrame.origin.x - newFrame.size.width
        frame = newFrame
    }

    func moveRight() {
        col += 1
        var newFrame = frame
        newFrame.origin.x = newFrame.origin.x + newFrame.size.width
        frame = newFrame
    }

    public func moveDown() {
        row += 1
        var newFrame = frame
        newFrame.origin.y = newFrame.origin.y + newFrame.size.height
        frame = newFrame
    }
}
