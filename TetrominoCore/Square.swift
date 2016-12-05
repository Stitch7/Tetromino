//
//  Square.swift
//  Tetromino
//
//  Created by Christopher Reitz on 05/12/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import Foundation

public protocol SquareViewType {
    var frame: CGRect { get set }
    var downOperation: (CGFloat, CGFloat) -> CGFloat { get }
    init(
        color: Color,
        boardRow: Int,
        boardCol: Int,
        pieceRow: Int,
        pieceCol: Int,
        width: CGFloat,
        height: CGFloat
    )
    func removeFromSuperview()
}

public class Square<T: SquareViewType> {

    var boardRow: Int
    var boardCol: Int
    var pieceRow: Int
    var pieceCol: Int
    var width: CGFloat
    var height: CGFloat

    public var row: Int
    public var col: Int

    public var view: T

    init(
        color: Color,
        boardRow: Int,
        boardCol: Int,
        pieceRow: Int,
        pieceCol: Int,
        width: CGFloat,
        height: CGFloat
    ) {
        self.boardRow = boardRow
        self.boardCol = boardCol
        self.pieceRow = pieceRow
        self.pieceCol = pieceCol
        self.width = width
        self.height = height

        row = boardRow + pieceRow
        col = boardCol + pieceCol
        view = T(
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

    func moveDown() {
        row += 1
        var newFrame = view.frame
        newFrame.origin.y = view.downOperation(newFrame.origin.y, newFrame.size.height)
        view.frame = newFrame
    }
}
