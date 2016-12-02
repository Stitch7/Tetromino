//
//  Score.swift
//  TetrominoTouch
//
//  Created by Christopher Reitz on 13/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

struct Score: ExpressibleByIntegerLiteral {

    // MARK: - Properties

    var value: Int
    var rowsCompleted = 0

    init(integerLiteral value: Int) {
        self.value = value
    }

    // MARK: - Public

    mutating func add(numberOfRows: Int, level: Level) {
        var newScore = 0
        switch numberOfRows {
        case 1:
            newScore += 40
        case 2:
            newScore += 100
        case 3:
            newScore += 300
        case 4:
            newScore += 1200
        default:
            break
        }

        newScore *= level.rawValue + 1
        value += newScore
        rowsCompleted += numberOfRows
    }
}
