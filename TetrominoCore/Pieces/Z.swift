//
//  Z.swift
//  Tetromino
//
//  Created by Christopher Reitz on 13/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

public class Z<T: SquareViewType>: Piece<T> {
    override init() {
        super.init()
        color = .orange
        pattern = [
            [true, true, false, false],
            [false, true, true, false],
            [false, false, false, false],
            [false, false, false, false],
        ]
    }
}
