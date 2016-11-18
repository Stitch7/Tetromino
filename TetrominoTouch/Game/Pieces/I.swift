//
//  I.swift
//  TetrominoTouch
//
//  Created by Christopher Reitz on 13/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

struct I: Piece {
    let color = UIColor.flatGreen
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
