//
//  Tetrimino.swift
//  Tetris
//
//  Created by Christopher Reitz on 03/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

protocol Piece {
    typealias Pattern = [[Bool]]

    var color: UIColor { get }
    var pattern: Pattern { get set }
    var squares: [Square] { get set }
    var currentRow: Int { get set }
    var currentCol: Int { get set }

    mutating func add(to view: UIView)
    mutating func rotate(in view: UIView)
    mutating func moveLeft()
    mutating func moveRight()
    mutating func moveDown()
    mutating func fallDown()

    func isHit(by touch: UITouch) -> Bool
}

extension Piece {
    mutating func add(to view: UIView) {
        squares = [Square]()
        let rowCount = 4
        let colCount = 4
        for rowNo in 0..<rowCount {
            for colNo in 0..<colCount {
                guard pattern[rowNo][colNo] else { continue }

                let square = Square(frame: CGRect(
                    x: CGFloat(currentCol) * Board.squareWidth + CGFloat(colNo) * Board.squareWidth,
                    y: CGFloat(currentRow) * Board.squareHeight + CGFloat(rowNo) * Board.squareHeight,
                    width: Board.squareWidth,
                    height: Board.squareHeight
                ))
                square.backgroundColor = color
                square.row = currentRow + rowNo
                square.col = currentCol + colNo
                squares.append(square)
                view.addSubview(square)
            }
        }
    }

    mutating func rotate(in view: UIView) {
        pattern = [
            [pattern[0][3], pattern[1][3], pattern[2][3], pattern[3][3]],
            [pattern[0][2], pattern[1][2], pattern[2][2], pattern[3][2]],
            [pattern[0][1], pattern[1][1], pattern[2][1], pattern[3][1]],
            [pattern[0][0], pattern[1][0], pattern[2][0], pattern[3][0]]
        ]
        for square in squares {
            square.removeFromSuperview()
        }
        add(to: view)

        if isOutsideLeft() {
            moveRight()
        }
        else if isOutsideRight() {
            moveLeft()
        }
    }

    private func isOutsideLeft() -> Bool {
        for square in squares {
            if square.frame.origin.x < 0 {
                return true
            }
        }
        return false
    }

    private func isOutsideRight() -> Bool {
        for square in squares {
            if square.frame.origin.x + square.frame.size.width > Board.width {
                return true
            }
        }
        return false
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

// MARK: Random Factory

extension Piece {
    static func random() -> Piece {
        switch arc4random_uniform(10) {
        case 0: return I()
        case 1: return O()
        case 2: return Z()
        case 3: return T()
        case 4: return L()
        case 5: return I()
        case 6: return O()
        case 7: return Z()
        case 8: return T()
        case 9: return L()
        default: return L()
        }
    }
}

struct I: Piece {
    let color = UIColor.green
    var squares = [Square]()
    var currentRow = 0
    var currentCol = 3
    var pattern: Piece.Pattern = [
        [true, false, false, false],
        [true, false, false, false],
        [true, false, false, false],
        [true, false, false, false]
    ]
}

struct O: Piece {
    let color = UIColor.red
    var squares = [Square]()
    var currentRow = 0
    var currentCol = 3
    var pattern: Piece.Pattern = [
        [false, false, false, false],
        [false, true, true, false],
        [false, true, true, false],
        [false, false, false, false],
    ]
}

struct Z: Piece {
    let color = UIColor.orange
    var squares = [Square]()
    var currentRow = 0
    var currentCol = 3
    var pattern: Piece.Pattern = [
        [true, true, false, false],
        [false, true, true, false],
        [false, false, false, false],
        [false, false, false, false],
    ]
}

struct T: Piece {
    let color = UIColor.yellow
    var squares = [Square]()
    var currentRow = 0
    var currentCol = 3
    var pattern: Piece.Pattern = [
        [true, true, true, false],
        [false, true, false, false],
        [false, false, false, false],
        [false, false, false, false],
    ]
}

struct L: Piece {
    let color = UIColor.blue
    var squares = [Square]()
    var currentRow = 0
    var currentCol = 3
    var pattern: Piece.Pattern = [
        [false, true, false, false],
        [false, true, false, false],
        [false, true, true, false],
        [false, false, false, false]
    ]
}
