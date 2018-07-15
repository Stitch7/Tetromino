//
//  Boards.swift
//  TetrominoCore
//
//  Created by Christopher Reitz on 03/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import CoreGraphics

public struct Board<ViewType: SquareViewType> {

    // MARK: - Properties

    public let width: CGFloat
    public let height: CGFloat

    let numRows = 20
    let numCols = 10

    var squareWidth: CGFloat
    var squareHeight: CGFloat
    var grid = [[Square<ViewType>?]]()

    var completedRows: [Int] {
        var rows = [Int]()
        for (i, row) in grid.enumerated() {
            if row.compactMap({ $0 }).count == row.count {
                rows.append(i)
            }
        }

        return rows
    }

    // MARK: - Initializers

    public init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
        squareWidth = width / CGFloat(numCols)
        squareHeight = height / CGFloat(numRows)
        reset()
    }

    private mutating func insertEmptyRows(count: Int) {
        for _ in 0..<count {
            grid.insert([Square?](repeating: nil, count: numCols), at: 0)
        }
    }

    // MARK: - Public

    mutating func reset() {
        if grid.count > 0 {
            walkAllSlots { row, col in
                if let square = grid[row][col] {
                    square.remove()
                }
            }
        }
        grid = [[Square?]]()
        insertEmptyRows(count: numRows)
    }

    mutating func add(piece: Piece<ViewType>) {
        for square in piece.squares {
            grid[square.row][square.col] = square
        }
    }

    func walkSlots(_ range: CountableRange<Int>, completion: ((Int, Int) -> Void)) {
        for row in range {
            for col in 0..<numCols {
                completion(row, col)
            }
        }
    }

    func walkAllSlots(completion: ((Int, Int) -> Void)) {
        walkSlots(0..<numRows, completion: completion)
    }

    mutating func killCompletedRows() -> Int {
        let completedRows = self.completedRows

        for row in completedRows.reversed() {
            for square in grid[row] {
                square?.remove()
            }
            grid.remove(at: row)
        }
        insertEmptyRows(count: completedRows.count)

        walkAllSlots { row, col in
            guard let square = grid[row][col] else { return }
            for _ in 0..<row - square.row {
                square.moveDown()
            }
        }

        return completedRows.count
    }

    func intersects(with piece: Piece<ViewType>?) -> Bool {
        guard let piece = piece else { return false }
        return intersectsLeft(with: piece)
            || intersectsRight(with: piece)
            || intersectsBottom(with: piece)
    }

    func intersectsLeft(with piece: Piece<ViewType>?) -> Bool {
        guard let piece = piece else { return false }

        for square in piece.squares {
            if square.col == 0 {
                return true
            }

            for boardRow in grid {
                for toCompare in boardRow.compactMap({ $0 }) {
                    if square.row == toCompare.row && square.col == toCompare.col + 1 {
                        return true
                    }
                }
            }
        }
        return false
    }

    func intersectsRight(with piece: Piece<ViewType>?) -> Bool {
        guard let piece = piece else { return false }

        for square in piece.squares {
            if square.col == numCols - 1 {
                return true
            }

            for boardRow in grid {
                for toCompare in boardRow.compactMap({ $0 }) {
                    if square.row == toCompare.row && square.col == toCompare.col - 1 {
                        return true
                    }
                }
            }
        }
        return false
    }

    func intersectsBottom(with piece: Piece<ViewType>?) -> Bool {
        guard let piece = piece else { return false }
        
        for square in piece.squares {
            if square.row == numRows - 1 {
                return true
            }

            for boardRow in grid {
                for toCompare in boardRow.compactMap({ $0 }) {
                    if square.col == toCompare.col && square.row == toCompare.row - 1 {
                        return true
                    }
                }
            }
        }
        return false
    }
}
