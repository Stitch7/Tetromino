//
//  Boards.swift
//  Tetris
//
//  Created by Christopher Reitz on 03/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

struct Board {

    typealias Grid = [[Square?]]

    static let numRows = 20
    static let numCols = 10

    var grid: Grid

    init() {
        grid = Grid()
        for _ in 0..<Board.numRows {
            grid.append([Square?](repeating: nil, count: Board.numCols))
        }
    }

    mutating func add(piece: Tetrimino) {
        for square in piece.squares {
            grid[square.currentRow][square.currentCol] = square
        }
    }

    func intersectsRight(with piece: Tetrimino) -> Bool {
        for square in piece.squares {
            if square.currentCol == Board.numCols - 1 {
                return true
            }
        }

        return false
    }

    func intersectsLeft(with piece: Tetrimino) -> Bool {
        for square in piece.squares {
            if square.currentCol == 0 {
                return true
            }
        }

        return false
    }

    func intersectsBottom(with piece: Tetrimino) -> Bool {
        for square in piece.squares {
            if square.currentRow == Board.numRows {
                return true
            }
        }

        return false
    }
}
