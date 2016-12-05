//
//  Square.swift
//  TetrominoMac
//
//  Created by Christopher Reitz on 03/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import AppKit
import TetrominoCoreMac

final class SquareView: NSView, SquareViewType {

    // MARK: - Properties

    var downOperation: (CGFloat, CGFloat) -> CGFloat = (-)
    let color: Color

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
        self.color = color
        let frame = CGRect(
            x: CGFloat(boardCol) * width + CGFloat(pieceCol) * width,
            y: 960 - CGFloat(boardRow + pieceRow + 1) * height,
            width: width,
            height: height
        )
        super.init(frame: frame)

        wantsLayer = true
    }

    required public init?(coder aDecoder: NSCoder) {
        return nil
    }

    override public func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        layer?.backgroundColor = color.nsColor.cgColor
    }
}
