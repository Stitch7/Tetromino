//
//  L.swift
//  Tetromino
//
//  Created by Christopher Reitz on 13/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

struct L: Piece {
    let color = Color.blue
    var squares = [Square]()
    var currentRow = 0
    var currentCol = 3
    var pattern: Pattern = [
        [false, true, false, false],
        [false, true, false, false],
        [false, true, true, false],
        [false, false, false, false]
    ]
}
