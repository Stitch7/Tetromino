//
//  Tetrimino.swift
//  TetrominoTouch
//
//  Created by Christopher Reitz on 03/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import CoreGraphics.CGGeometry
import UIKit.UIColor

typealias Pattern = [[Bool]]

// MARK: Piece

protocol Piece {
    var color: UIColor { get }
    var pattern: Pattern { get set }
    var squares: [Square] { get set }
    var currentRow: Int { get set }
    var currentCol: Int { get set }
    var rotated: Piece { get }
    var leftX: CGFloat { get }
    var rightX: CGFloat { get }

    mutating func build(width: CGFloat, height: CGFloat)
    mutating func moveLeft()
    mutating func moveRight()
    mutating func moveDown()
}

// MARK: Piece Implementation

extension Piece {

    var leftX: CGFloat {
        let leftSquare = squares.sorted(by: {$0.col < $1.col }).first!
        return leftSquare.frame.origin.x
    }

    var rightX: CGFloat {
        let rightSquare = squares.sorted(by: {$0.col < $1.col }).last!
        return rightSquare.frame.origin.x + rightSquare.frame.size.width
    }

    var rotated: Piece {
        var rotated = self
        rotated.pattern = [
            [pattern[0][3], pattern[1][3], pattern[2][3], pattern[3][3]],
            [pattern[0][2], pattern[1][2], pattern[2][2], pattern[3][2]],
            [pattern[0][1], pattern[1][1], pattern[2][1], pattern[3][1]],
            [pattern[0][0], pattern[1][0], pattern[2][0], pattern[3][0]]
        ]
        rotated.build(width: squares.first!.frame.width, height: squares.first!.frame.height)
        return rotated
    }

    mutating func build(width: CGFloat, height: CGFloat) {
        squares = [Square]()
        let rowCount = 4
        let colCount = 4
        for rowNo in 0..<rowCount {
            for colNo in 0..<colCount {
                guard pattern[rowNo][colNo] else { continue }

                let row = currentRow + rowNo
                let col = currentCol + colNo
                let frame = CGRect(
                    x: CGFloat(currentCol) * width + CGFloat(colNo) * width,
                    y: CGFloat(currentRow) * height + CGFloat(rowNo) * height,
                    width: width,
                    height: height
                )
                let square = Square(row: row, col: col, frame: frame)
                square.backgroundColor = color
                squares.append(square)
            }
        }
    }

    mutating func moveLeft() {
        currentCol -= 1
        for square in squares {
            square.col -= 1
            var newFrame = square.frame
            newFrame.origin.x = newFrame.origin.x - newFrame.size.width
            square.frame = newFrame
        }
    }

    mutating func moveRight() {
        currentCol += 1
        for square in squares {
            square.col += 1
            var newFrame = square.frame
            newFrame.origin.x = newFrame.origin.x + newFrame.size.width
            square.frame = newFrame
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
