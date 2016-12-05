//
//  T.swift
//  Tetromino
//
//  Created by Christopher Reitz on 13/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

public class T<T: SquareViewType>: Piece<T> {
    override init() {
        super.init()
        color = .yellow
        pattern = [
            [true, true, true, false],
            [false, true, false, false],
            [false, false, false, false],
            [false, false, false, false],
        ]
    }
}
