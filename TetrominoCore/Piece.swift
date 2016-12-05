//
//  Tetrimino.swift
//  Tetromino
//
//  Created by Christopher Reitz on 03/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import CoreGraphics

public typealias Pattern = [[Bool]]


// MARK: Piece

public protocol Piece {
    var color: Color { get }
    var pattern: Pattern { get set }
    var squares: [Square] { get set }
    var currentRow: Int { get set }
    var currentCol: Int { get set }
    var rotated: Piece { get }

    mutating func build(width: CGFloat, height: CGFloat)
    mutating func moveLeft()
    mutating func moveRight()
    mutating func moveDown()
}

// MARK: Piece Implementation

public extension Piece {
    var rotated: Piece {
        var rotated = self
        rotated.pattern = [
            [pattern[0][3], pattern[1][3], pattern[2][3], pattern[3][3]],
            [pattern[0][2], pattern[1][2], pattern[2][2], pattern[3][2]],
            [pattern[0][1], pattern[1][1], pattern[2][1], pattern[3][1]],
            [pattern[0][0], pattern[1][0], pattern[2][0], pattern[3][0]]
        ]
        rotated.build(width: squares.first!.view.frame.width, height: squares.first!.view.frame.height)
        return rotated
    }

    mutating func build(width: CGFloat, height: CGFloat) {
        squares = [Square]()
        let rowCount = 4
        let colCount = 4
        for rowNo in 0..<rowCount {
            for colNo in 0..<colCount {
                guard pattern[rowNo][colNo] else { continue }

                let square = Square(
                    color: color,
                    boardRow: currentRow,
                    boardCol: currentCol,
                    pieceRow: rowNo,
                    pieceCol: colNo,
                    width: width,
                    height: height
                )
                squares.append(square)
            }
        }
    }

    mutating func moveLeft() {
        currentCol -= 1
        for square in squares {
            square.moveLeft()
        }
    }

    mutating func moveRight() {
        currentCol += 1
        for square in squares {
            square.moveRight()
        }
    }

    mutating func moveDown() {
        currentRow += 1
        for square in squares {
            square.moveDown()
        }
    }
}

struct PieceFactory {
    static func random() -> Piece {
        let pieceIndex = 1 + ((arc4random_uniform(7) + 1) % 7)
        switch pieceIndex {
        case 1: return O()
        case 2: return I()
        case 3: return S()
        case 4: return Z()
        case 5: return L()
        case 6: return J()
        case 7: return T()
        default: fatalError("Piece randomizer out of bounds")
        }
    }
}
