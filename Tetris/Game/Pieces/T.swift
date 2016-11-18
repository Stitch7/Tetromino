//
//  T.swift
//  Tetris
//
//  Created by Christopher Reitz on 13/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

struct T: Piece {
    let color = UIColor.flatYellow
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
