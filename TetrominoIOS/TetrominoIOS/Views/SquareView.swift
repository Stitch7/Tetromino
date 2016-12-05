//
//  Square.swift
//  TetrominoTouch
//
//  Created by Christopher Reitz on 03/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit
import TetrominoCoreIOS

class SquareView: UIView, SquareViewType {

    // MARK: - Properties

    var downOperation: (CGFloat, CGFloat) -> CGFloat = (+)

    var row: Int
    var col: Int

    // MARK: - Initializers

    public required init(
        color: Color,
        boardRow: Int,
        boardCol: Int,
        pieceRow: Int,
        pieceCol: Int,
        width: CGFloat,
        height: CGFloat
    ) {
        row = boardRow + pieceRow
        col = boardCol + pieceCol
        let frame = CGRect(
            x: CGFloat(boardCol) * width + CGFloat(pieceCol) * width,
            y: CGFloat(boardRow) * height + CGFloat(pieceRow) * height,
            width: width,
            height: height
        )
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
}
