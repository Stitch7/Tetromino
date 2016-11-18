//
//  O.swift
//  TetrominoTouch
//
//  Created by Christopher Reitz on 13/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

struct O: Piece {
    let color = UIColor.flatRed
    var squares = [Square]()
    var currentRow = 0
    var currentCol = 3
    var pattern: Pattern = [
        [false, false, false, false],
        [false, true, true, false],
        [false, true, true, false],
        [false, false, false, false],
    ]
}
