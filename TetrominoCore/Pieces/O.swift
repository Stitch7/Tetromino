//
//  O.swift
//  Tetromino
//
//  Created by Christopher Reitz on 13/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

public struct O: Piece {
    public let color = Color.red
    public var squares = [Square]()
    public var currentRow = 0
    public var currentCol = 3
    public var pattern: Pattern = [
        [false, false, false, false],
        [false, true, true, false],
        [false, true, true, false],
        [false, false, false, false],
    ]
}
