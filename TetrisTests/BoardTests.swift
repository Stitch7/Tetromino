//
//  BoardTests.swift
//  Tetris
//
//  Created by Christopher Reitz on 12/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import XCTest
@testable import Tetris

class BoardTests: XCTestCase {

    // MARK: - XCTestCase
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Tests
    
    func test4PiecesInARowGetKilled() {
        var board = Board()
        let last4Rows = Board.numRows-4..<Board.numRows
        board.walkSlots(last4Rows) { row, col in
            board.grid[row][col] = Square(row: row, col: col)
        }
        assert(board.completedRows.count == 4)

        board.killCompletedRows()
        XCTAssert(board.completedRows.count == 0)
    }

    func testRemainingRowsWillMoveDownAfterKillCompletedRows() {
        var board = Board()
        let last4Rows = Board.numRows-5..<Board.numRows
        board.walkSlots(last4Rows) { row, col in
            if row == Board.numRows-5 && col == 0 { return }

            board.grid[row][col] = Square(row: row, col: col)
        }
        assert(board.completedRows.count == 4)

        board.killCompletedRows()
        assert(board.completedRows.count == 0)

        var noSquaresFoundInLastRow = true
        let lastRow: CountableRange<Int> = Board.numRows-1..<Board.numRows
        board.walkSlots(lastRow) { row, col in
            if col == 0 { return }
            noSquaresFoundInLastRow = board.grid[row][col] == nil
        }
        XCTAssertFalse(noSquaresFoundInLastRow, "Squares didn't move down")
    }
}
