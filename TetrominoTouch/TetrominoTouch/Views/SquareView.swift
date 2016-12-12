//
//  Square.swift
//  TetrominoTouch
//
//  Created by Christopher Reitz on 03/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit
import TetrominoTouchKit

final class SquareView: UIView, SquareViewType {

    // MARK: - Properties

    var config: SquareViewConfig
    var row: Int
    var col: Int

    // MARK: - Initializers

    init(config: SquareViewConfig) {
        self.config = config
        row = config.boardRow + config.pieceRow
        col = config.boardCol + config.pieceCol
        let frame = CGRect(
            x: CGFloat(config.boardCol) * config.width + CGFloat(config.pieceCol) * config.width,
            y: CGFloat(config.boardRow) * config.height + CGFloat(config.pieceRow) * config.height,
            width: config.width,
            height: config.height
        )
        super.init(frame: frame)

        backgroundColor = config.color.uiColor
    }

    required public init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: - SquareViewType

    public func remove() {
        removeFromSuperview()
    }

    func moveLeft() {
        var newFrame = frame
        newFrame.origin.x = newFrame.origin.x - newFrame.size.width
        frame = newFrame
    }

    func moveRight() {
        var newFrame = frame
        newFrame.origin.x = newFrame.origin.x + newFrame.size.width
        frame = newFrame
    }

    func moveDown() {
        var newFrame = frame
        newFrame.origin.y = newFrame.origin.y + newFrame.size.height
        frame = newFrame
    }

    // MARK: - Public

    public func isHit(by gesture: UITapGestureRecognizer) -> Bool {
        return hitTest(gesture.location(in: self), with: nil) != nil
    }
}
