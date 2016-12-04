//
//  T.swift
//  Tetromino
//
//  Created by Christopher Reitz on 13/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

struct T: Piece {
    let color = Color.yellow
    var squares = [Square]()
    var currentRow = 0
    var currentCol = 3
    var pattern: Pattern = [
        [true, true, true, false],
        [false, true, false, false],
        [false, false, false, false],
        [false, false, false, false],
    ]
}
