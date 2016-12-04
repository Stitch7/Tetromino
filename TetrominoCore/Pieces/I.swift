//
//  I.swift
//  Tetromino
//
//  Created by Christopher Reitz on 13/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

struct I: Piece {
    let color = Color.green
    var squares = [Square]()
    var currentRow = 0
    var currentCol = 4
    var pattern: Pattern = [
        [true, false, false, false],
        [true, false, false, false],
        [true, false, false, false],
        [true, false, false, false]
    ]
}
