//
//  Boards.swift
//  Tetris
//
//  Created by Christopher Reitz on 03/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

struct Board {

    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
    static let squareWidth = Board.width / CGFloat(Board.numCols)
    static let squareHeight = Board.height / CGFloat(Board.numRows)
    static let numRows = 20
    static let numCols = 10

    var grid: [[Square?]]

    var completedRows: [Int] {
        var rows = [Int]()
        for (i, row) in grid.enumerated() {
            if row.flatMap({ $0 }).count == row.count {
                rows.append(i)
            }
        }

        return rows
    }

    // MARK: - Initializers

    init() {
        grid = [[Square?]]()
        insertEmptyRows(count: Board.numRows)
    }

    mutating func insertEmptyRows(count: Int) {
        for _ in 0..<count {
            grid.insert([Square?](repeating: nil, count: Board.numCols), at: 0)
        }
    }

    mutating func add(piece: Piece) {
        for square in piece.squares {
            grid[square.row][square.col] = square
        }
    }

    func walkSlots(_ range: CountableRange<Int> = 0..<Board.numRows, completion: ((Int, Int) -> Void)) {
        for row in range {
            for col in 0..<Board.numCols {
                completion(row, col)
            }
        }
    }

    mutating func killCompletedRows() {
        let completedRows = self.completedRows

        for row in completedRows.reversed() {
            for square in grid[row] {
                square?.removeFromSuperview()
            }
            grid.remove(at: row)
        }
        insertEmptyRows(count: completedRows.count)

        walkSlots { row, col in
            guard let square = grid[row][col] else { return }
            for _ in 0..<row - square.row {
                square.moveDown()
            }
        }
    }

    func intersectsRight(with piece: Piece) -> Bool {
        for square in piece.squares {
            if square.col == Board.numCols - 1 {
                return true
            }

            for boardRow in grid {
                for toCompare in boardRow.flatMap({ $0 }) {
                    if square.row == toCompare.row && square.col == toCompare.col - 1 {
                        return true
                    }
                }
            }
        }
        return false
    }

    func intersectsLeft(with piece: Piece) -> Bool {
        for square in piece.squares {
            if square.col == 0 {
                return true
            }

            for boardRow in grid {
                for toCompare in boardRow.flatMap({ $0 }) {
                    if square.row == toCompare.row && square.col == toCompare.col + 1 {
                        return true
                    }
                }
            }
        }
        return false
    }

    func intersectsBottom(with piece: Piece) -> Bool {
        for square in piece.squares {
            if square.row == Board.numRows - 1 {
                return true
            }

            for boardRow in grid {
                for toCompare in boardRow.flatMap({ $0 }) {
                    if square.col == toCompare.col && square.row == toCompare.row - 1 {
                        return true
                    }
                }
            }
        }
        return false
    }
}
