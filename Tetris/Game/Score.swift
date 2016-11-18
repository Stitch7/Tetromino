//
//  Score.swift
//  Tetris
//
//  Created by Christopher Reitz on 13/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

struct Score: ExpressibleByIntegerLiteral {

    // MARK: - Properties

    var value: Int

    init(integerLiteral value: Int) {
        self.value = value
    }

    // MARK: - Public

    mutating func add(numberOfRows: Int) {
        var score = numberOfRows * 100
        if numberOfRows == 4 {
            score += 100
        }
        value += score
    }
}
