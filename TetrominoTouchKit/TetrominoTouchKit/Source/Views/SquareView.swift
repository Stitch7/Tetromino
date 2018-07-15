//
//  Square.swift
//  TetrominoTouchKit
//
//  Created by Christopher Reitz on 03/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

final class SquareView: UIView, SquareViewType {

    // MARK: - Properties

    var downOperation: (CGFloat, CGFloat) -> CGFloat = (+)

    var row: Int
    var col: Int

    // MARK: - Initializers

    init(config: SquareViewConfig) {
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

    // MARK: - Public

    public func isHit(by gesture: UITapGestureRecognizer) -> Bool {
        return hitTest(gesture.location(in: self), with: nil) != nil
    }
}
