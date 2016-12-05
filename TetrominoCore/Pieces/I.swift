//
//  I.swift
//  Tetromino
//
//  Created by Christopher Reitz on 13/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

public struct I: Piece {
    public let color = Color.green
    public var squares = [Square]()
    public var currentRow = 0
    public var currentCol = 4
    public var pattern: Pattern = [
        [true, false, false, false],
        [true, false, false, false],
        [true, false, false, false],
        [true, false, false, false]
    ]
}
