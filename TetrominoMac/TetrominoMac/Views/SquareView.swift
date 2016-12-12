//
//  Square.swift
//  TetrominoMac
//
//  Created by Christopher Reitz on 03/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import AppKit
import TetrominoMacKit

final class SquareView: NSView, SquareViewType {

    // MARK: - Properties

    var config: SquareViewConfig
    let color: Color

    // MARK: - Initializers

    init(config: SquareViewConfig) {
        self.config = config
        self.color = config.color
        let frame = CGRect(
            x: CGFloat(config.boardCol) * config.width + CGFloat(config.pieceCol) * config.width,
            y: config.height * 20 - CGFloat(config.boardRow + config.pieceRow + 1) * config.height,
            width: config.width,
            height: config.height
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
        newFrame.origin.y = newFrame.origin.y - newFrame.size.height
        frame = newFrame
    }
}
