//
//  S.swift
//  Tetromino
//
//  Created by Christopher Reitz on 13/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

public class S
    <T: SquareViewType>
: Piece<T> {
//    public let color = Color.cyan
//    public var squares = [Square]()
//    public var currentRow = 0
//    public var currentCol = 3
//    public var pattern: Pattern = [
//        [false, true, true, false],
//        [true, true, false, false],
//        [false, false, false, false],
//        [false, false, false, false],
//    ]
    override init() {
        super.init()
        color = .cyan
        pattern = [
            [false, true, true, false],
            [true, true, false, false],
            [false, false, false, false],
            [false, false, false, false],
        ]
    }
}
