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

public class Piece<T: SquareViewType> {
    var color = Color.blue
    var pattern = Pattern()
    public var squares = [Square<T>]()
    var currentRow = 0
    var currentCol = 3
}

// MARK: Piece Implementation

public extension Piece {
    var rotated: Piece {
//        let rotated = self
        let rotated = Piece()
        rotated.color = color
        rotated.pattern = [
            [pattern[0][3], pattern[1][3], pattern[2][3], pattern[3][3]],
            [pattern[0][2], pattern[1][2], pattern[2][2], pattern[3][2]],
            [pattern[0][1], pattern[1][1], pattern[2][1], pattern[3][1]],
            [pattern[0][0], pattern[1][0], pattern[2][0], pattern[3][0]]
        ]
        rotated.currentRow = currentRow
        rotated.currentCol = currentCol
        rotated.build(width: squares.first!.view.frame.width, height: squares.first!.view.frame.height)
        return rotated
    }

    func build(width: CGFloat, height: CGFloat) {
        squares = [Square]()
        let rowCount = 4
        let colCount = 4
        for rowNo in 0..<rowCount {
            for colNo in 0..<colCount {
                guard pattern[rowNo][colNo] else { continue }

                let square = Square<T>(
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

    func moveLeft() {
        currentCol -= 1
        for square in squares {
            square.moveLeft()
        }
    }

    func moveRight() {
        currentCol += 1
        for square in squares {
            square.moveRight()
        }
    }

    func moveDown() {
        currentRow += 1
        for square in squares {
            square.moveDown()
        }
    }
}

struct PieceFactory<T2: SquareViewType> {
    static func random() -> Piece<T2> {
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
