//
//  Square.swift
//  TetrominoMac
//
//  Created by Christopher Reitz on 03/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import AppKit

public class Square: NSView {

    // MARK: - Properties

    let color: Color
    var row = 0
    var col = 0

    // MARK: - Initializers

    init(color: Color, row: Int, col: Int, frame: CGRect = .zero) {
        self.color = color
        self.row = row
        self.col = col
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

    // MARK: - Public

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

    func moveDown() {
        row += 1
        var newFrame = frame
        newFrame.origin.y = newFrame.origin.y - newFrame.size.height
        frame = newFrame
    }
}
