//
//  Tetrimino.swift
//  Tetris
//
//  Created by Christopher Reitz on 03/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

typealias Pattern = [[Bool]]

// MARK: Piece

protocol Piece {
    var color: UIColor { get }
    var pattern: Pattern { get set }
    var squares: [Square] { get set }
    var currentRow: Int { get set }
    var currentCol: Int { get set }
    var rotated: Piece { get }

    mutating func build()
    mutating func moveLeft()
    mutating func moveRight()
    mutating func moveDown()
    mutating func fallDown()

    func isHit(by touch: UITouch) -> Bool
}

// MARK: Piece Implementation

extension Piece {
    mutating func build() {
        squares = [Square]()
        let rowCount = 4
        let colCount = 4
        for rowNo in 0..<rowCount {
            for colNo in 0..<colCount {
                guard pattern[rowNo][colNo] else { continue }

                let row = currentRow + rowNo
                let col = currentCol + colNo
                let frame = CGRect(
                    x: CGFloat(currentCol) * Board.squareWidth + CGFloat(colNo) * Board.squareWidth,
                    y: CGFloat(currentRow) * Board.squareHeight + CGFloat(rowNo) * Board.squareHeight,
                    width: Board.squareWidth,
                    height: Board.squareHeight
                )
                let square = Square(row: row, col: col, frame: frame)
                square.backgroundColor = color
                squares.append(square)
            }
        }
    }

    var rotated: Piece {
        var rotated = self
        rotated.pattern = [
            [pattern[0][3], pattern[1][3], pattern[2][3], pattern[3][3]],
            [pattern[0][2], pattern[1][2], pattern[2][2], pattern[3][2]],
            [pattern[0][1], pattern[1][1], pattern[2][1], pattern[3][1]],
            [pattern[0][0], pattern[1][0], pattern[2][0], pattern[3][0]]
        ]
        rotated.build()

        return rotated
    }

    mutating func moveLeft() {
        currentCol -= 1
        for square in squares {
            square.col -= 1
            var newFrame = square.frame
            newFrame.origin.x = newFrame.origin.x - Board.squareWidth
            square.frame = newFrame
        }
    }

    mutating func moveRight() {
        currentCol += 1
        for square in squares {
            square.col += 1
            var newFrame = square.frame
            newFrame.origin.x = newFrame.origin.x + Board.squareWidth
            square.frame = newFrame
        }
    }

    mutating func moveDown() {
        currentRow += 1
        for square in squares {
            square.moveDown()
        }
    }

    mutating func fallDown() {
        print("FALLING DOWN")
    }

    func isHit(by touch: UITouch) -> Bool {
        for square in squares {
            if square.isHit(by: touch) {
                return true
            }
        }
        return false
    }
}

// MARK: Tetris Pieces

extension Piece {
    static func random() -> Piece {
        switch arc4random_uniform(7) {
        case 0: return O()
        case 1: return I()
        case 2: return S()
        case 3: return Z()
        case 4: return L()
        case 5: return J()
        case 6: return T()
        default: fatalError("Piece randomizer out of bounds")
        }
    }
}

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

struct S: Piece {
    let color = UIColor.flatMint
    var squares = [Square]()
    var currentRow = 0
    var currentCol = 3
    var pattern: Pattern = [
        [false, true, true, false],
        [true, true, false, false],
        [false, false, false, false],
        [false, false, false, false],
    ]
}

struct Z: Piece {
    let color = UIColor.flatOrange
    var squares = [Square]()
    var currentRow = 0
    var currentCol = 3
    var pattern: Pattern = [
        [true, true, false, false],
        [false, true, true, false],
        [false, false, false, false],
        [false, false, false, false],
    ]
}

struct L: Piece {
    let color = UIColor.flatBlue
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

struct J: Piece {
    let color = UIColor.flatPurple
    var squares = [Square]()
    var currentRow = 0
    var currentCol = 3
    var pattern: Pattern = [
        [false, false, true, false],
        [false, false, true, false],
        [false, true, true, false],
        [false, false, false, false]
    ]
}

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
