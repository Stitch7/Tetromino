//
//  LevelTextFieldCell.swift
//  TetrominoMac
//
//  Created by Christopher Reitz on 08/12/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import AppKit

class LevelTextFieldCell: NSTextFieldCell {

    var topPadding: CGFloat = 10.0

    override func drawingRect(forBounds rect: NSRect) -> NSRect {
        let rectInset = NSMakeRect(rect.origin.x, rect.origin.y + topPadding, rect.size.width, rect.size.height - topPadding)
        return super.drawingRect(forBounds: rectInset)
    }
}
