//
//  Tetrimino.swift
//  Tetris
//
//  Created by Christopher Reitz on 03/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

//fileprivate
let edgeLength = UIScreen.main.bounds.width / CGFloat(Board.numCols)

protocol Tetrimino {
    typealias Pattern = [[Bool]]
    var pattern: Pattern { get set }
    var squares: [Square] { get set }
    var currentRow: Int { get set }
    var currentCol: Int { get set }
    mutating func add(to view: UIView)
    mutating func rotate(in view: UIView)
    mutating func moveDone()
    mutating func moveLeft()
    mutating func moveRight()
    func isHit(by touch: UITouch) -> Bool
}

extension Tetrimino {
    mutating func add(to view: UIView) {
        squares = [Square]()
        let rowCount = 4
        let colCount = 4
        for rowNo in 0..<rowCount {
            for colNo in 0..<colCount {
                guard pattern[rowNo][colNo] else { continue }

                let square = Square(frame: CGRect(
                    x: CGFloat(currentCol) * edgeLength + CGFloat(colNo) * edgeLength,
                    y: CGFloat(currentRow) * edgeLength + CGFloat(rowNo) * edgeLength,
                    width: edgeLength,
                    height: edgeLength
                ))
                square.currentRow = currentRow + rowNo
                square.currentCol = currentCol + colNo
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

        if isOutside() {
            moveRight()
        }
    }

    mutating func moveDone() {
        currentRow += 1
        for square in squares {
            square.currentRow += 1
            var newFrame = square.frame
            newFrame.origin.y = newFrame.origin.y + edgeLength
            square.frame = newFrame
        }
    }

    mutating func moveLeft() {
        currentCol -= 1
        for square in squares {
            square.currentCol -= 1
            var newFrame = square.frame
            newFrame.origin.x = newFrame.origin.x - edgeLength
            square.frame = newFrame
        }
    }

    mutating func moveRight() {
        currentCol += 1
        for square in squares {
            square.currentCol += 1
            var newFrame = square.frame
            newFrame.origin.x = newFrame.origin.x + edgeLength
            square.frame = newFrame
        }
    }

    func isOutside() -> Bool {
        for square in squares {
            if square.frame.origin.x < 0 {
                return true
            }
        }

        return false
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

//struct I: Tetrimino {
//    var squares = [Square]()
//    var pattern: [[Bool]] = [
//        [true, false, false, false],
//        [true, false, false, false],
//        [true, false, false, false],
//        [true, false, false, false]
//    ]
//}
//
//struct O: Tetrimino {
//    var squares = [Square]()
//    var pattern: [[Bool]] = [
//        [false, false, false, false],
//        [false, true, true, false],
//        [false, true, true, false],
//        [false, false, false, false],
//    ]
//}
//
//struct Z: Tetrimino {
//    var squares = [Square]()
//    var pattern: [[Bool]] = [
//        [true, true, false, false],
//        [false, true, true, false],
//        [false, false, false, false],
//        [false, false, false, false],
//    ]
//}
//
//struct T: Tetrimino {
//    var squares = [Square]()
//    var pattern: [[Bool]] = [
//        [true, true, true, false],
//        [false, true, false, false],
//        [false, false, false, false],
//        [false, false, false, false],
//    ]
//}

struct L: Tetrimino {
    var squares = [Square]()
    var currentRow = 0
    var currentCol = 3
    var pattern: Tetrimino.Pattern = [
        [false, true, false, false],
        [false, true, false, false],
        [false, true, true, false],
        [false, false, false, false]
    ]
}
