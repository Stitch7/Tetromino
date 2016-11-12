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

    init() {
        grid = [[Square?]]()
        for _ in 0..<Board.numRows {
            grid.append([Square?](repeating: nil, count: Board.numCols))
        }
    }

    mutating func add(piece: Piece) {
        
        for square in piece.squares {
            grid[square.row][square.col] = square
        }
    }

    mutating func killRows() {
        var completedRows = [Int]()
        for (i, row) in grid.enumerated() {
            if row.flatMap({ $0 }).count == row.count {
                completedRows.append(i)
            }
        }

        if completedRows.count > 0 {
            for row in completedRows {
                for square in grid[row] {
                    square?.removeFromSuperview()
                }
                grid[row] = [Square?](repeating: nil, count: Board.numCols)
            }

            for row in completedRows {
                if grid[row].flatMap({ $0 }).count == 0 {
                    for rowNoToMove in (Board.numRows - row..<Board.numRows).reversed() {
                        for square in grid[rowNoToMove].flatMap({ $0 }) {
                            square.moveDown()
                        }
                    }
                }
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
                for boardSquare in boardRow {
                    guard let toCompare = boardSquare else { continue }
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
                for boardSquare in boardRow {
                    guard let toCompare = boardSquare else { continue }
                    if square.col == toCompare.col && square.row == toCompare.row - 1 {
                        return true
                    }
                }
            }
        }
        return false
    }
}
