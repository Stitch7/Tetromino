//
//  Square.swift
//  TetrominoKit
//
//  Created by Christopher Reitz on 05/12/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import CoreGraphics

public struct SquareViewConfig {
    public let color: Color
    public var boardRow: Int
    public var boardCol: Int
    public let pieceRow: Int
    public let pieceCol: Int
    public let width: CGFloat
    public let height: CGFloat
}

public protocol SquareViewType {
    var config: SquareViewConfig { get set }
    init(config: SquareViewConfig)
    func remove()
    func moveLeft()
    func moveRight()
    func moveDown()
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
        view.remove()
    }

    func moveLeft() {
        col -= 1
        view.moveLeft()
    }

    func moveRight() {
        col += 1
        view.moveRight()
    }

    func moveDown() {
        row += 1
        view.moveDown()
    }
}
