//
//  Square.swift
//  TetrominoCore
//
//  Created by Christopher Reitz on 05/12/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import CoreGraphics

public struct SquareViewConfig {
    public let color: Color
    public let boardRow: Int
    public let boardCol: Int
    public let pieceRow: Int
    public let pieceCol: Int
    public let width: CGFloat
    public let height: CGFloat
}

public protocol SquareViewType {
    var frame: CGRect { get set }
    var downOperation: (CGFloat, CGFloat) -> CGFloat { get }
    init(config: SquareViewConfig)
    func removeFromSuperview()
}

public class Square<ViewType: SquareViewType> {

    // MARK: - Properties

    public var view: ViewType
    public var row: Int
    public var col: Int

    // MARK: - Initializers

    init(config: SquareViewConfig) {
        view = ViewType(config: config)
        row = config.boardRow + config.pieceRow
        col = config.boardCol + config.pieceCol
    }

    // MARK: - Public

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
