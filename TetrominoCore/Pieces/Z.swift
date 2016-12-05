//
//  Z.swift
//  Tetromino
//
//  Created by Christopher Reitz on 13/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

public struct Z: Piece {
    public let color = Color.orange
    public var squares = [Square]()
    public var currentRow = 0
    public var currentCol = 3
    public var pattern: Pattern = [
        [true, true, false, false],
        [false, true, true, false],
        [false, false, false, false],
        [false, false, false, false],
    ]
}
