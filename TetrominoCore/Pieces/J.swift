//
//  J.swift
//  Tetromino
//
//  Created by Christopher Reitz on 13/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//


public class J<T: SquareViewType>: Piece<T> {
    override init() {
        super.init()
        color = .purple
        pattern = [
            [false, false, true, false],
            [false, false, true, false],
            [false, true, true, false],
            [false, false, false, false]
        ]
    }
}
