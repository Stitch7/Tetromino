//
//  Square.swift
//  TetrominoTouch
//
//  Created by Christopher Reitz on 03/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

public class Square {

    var boardRow: Int
    var boardCol: Int
    var pieceRow: Int
    var pieceCol: Int
    var width: CGFloat
    var height: CGFloat

    public var row: Int
    public var col: Int
    public var view: SquareView

    init(color: Color, boardRow: Int, boardCol: Int, pieceRow: Int, pieceCol: Int, width: CGFloat, height: CGFloat) {
        self.boardRow = boardRow
        self.boardCol = boardCol
        self.pieceRow = pieceRow
        self.pieceCol = pieceCol
        self.width = width
        self.height = height

        row = boardRow + pieceRow
        col = boardCol + pieceCol
        view = SquareView(
            color: color,
            boardRow: boardRow,
            boardCol: boardCol,
            pieceRow: pieceRow,
            pieceCol: pieceCol,
            width: width,
            height: height
        )
    }

    public func remove() {
        view.removeFromSuperview()
    }

    func moveLeft() {
        col -= 1
        var newFrame = view.frame
        newFrame.origin.x = newFrame.origin.x - newFrame.size.width
        view.frame = newFrame
    }

    func moveRight() {
        col += 1
        var newFrame = view.frame
        newFrame.origin.x = newFrame.origin.x + newFrame.size.width
        view.frame = newFrame
    }

    // TODO: + || -
    func moveDown() {
        row += 1
        var newFrame = view.frame
        newFrame.origin.y = newFrame.origin.y + newFrame.size.height
        view.frame = newFrame
    }
}

public class SquareView: UIView {

    // MARK: - Initializers

    public init(
        color: Color,
        boardRow: Int,
        boardCol: Int,
        pieceRow: Int,
        pieceCol: Int,
        width: CGFloat,
        height: CGFloat
    ) {
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
