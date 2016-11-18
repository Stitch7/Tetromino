//
//  BoardTests.swift
//  Tetris
//
//  Created by Christopher Reitz on 12/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

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
        let numRows = 4

        var board = Board(width: 0, height: 0)
        // complete the last 4 rows by placing squares in all cols
        let last4Rows = board.numRows-numRows..<board.numRows
        board.walkSlots(last4Rows) { row, col in
            board.grid[row][col] = Square(row: row, col: col)
        }
        assert(board.completedRows.count == numRows)

        let killedRows = board.killCompletedRows()

        // test if `killCompletedRows` returns correct number of killed rows
        XCTAssert(
            killedRows == numRows,
            "killCompletedRows doesn't kill \(numRows) rows"
        )

        // test if no complete row remains after `killCompletedRows`
        XCTAssert(
            board.completedRows.count == 0,
            "Completed rows remaining after killCompletedRows"
        )
    }

    func testRemainingRowsWillMoveDownAfterKillCompletedRows() {
        var board = Board(width: 0, height: 0)
        let last4Rows = board.numRows-5..<board.numRows
        board.walkSlots(last4Rows) { row, col in
            if row == board.numRows-5 && col == 0 { return }
            board.grid[row][col] = Square(row: row, col: col)
        }
        assert(board.completedRows.count == 4)

        _ = board.killCompletedRows()
        assert(board.completedRows.count == 0)

        var noSquaresFoundInLastRow = true
        let lastRow: CountableRange<Int> = board.numRows-1..<board.numRows
        board.walkSlots(lastRow) { row, col in
            if col == 0 { return }
            noSquaresFoundInLastRow = board.grid[row][col] == nil
        }
        XCTAssertFalse(
            noSquaresFoundInLastRow,
            "Squares didn't move down"
        )
    }

    func testIntersectsRightWithBorder() {
        var piece = I()
        piece.build(width: 0, height: 0)
        for _ in 0..<5 {
            piece.moveDown()
        }
        for _ in 0..<5 {
            piece.moveRight()
        }

        XCTAssertTrue(
            Board(width: 0, height: 0).intersectsRight(with: piece),
            "Piece I on last col does not intersect with right border"
        )
    }

    func testNotIntersectsRightWithBorder() {
        var piece = I()
        piece.build(width: 0, height: 0)
        for _ in 0..<5 {
            piece.moveDown()
        }

        XCTAssertFalse(
            Board(width: 0, height: 0).intersectsRight(with: piece),
            "Piece I intersects right on empty board from middle of screen"
        )
    }

    func testIntersectsRightWithSquaresOnBoard() {
        var board = Board(width: 0, height: 0)
        board.walkAllSlots { row, col in
            if col != 5 { return }
            board.grid[row][col] = Square(row: row, col: col)
        }

        var piece = I()
        piece.build(width: 0, height: 0)
        board.add(piece: piece)
        for _ in 0..<5 {
            piece.moveDown()
        }
        
        XCTAssertTrue(
            board.intersectsRight(with: piece),
            "Piece I not intersects with squares on right from board"
        )
    }

    func testIntersectsLeftWithBorder() {
        var piece = I()
        piece.build(width: 0, height: 0)
        for _ in 0..<5 {
            piece.moveDown()
        }
        for _ in 0..<4 {
            piece.moveLeft()
        }

        XCTAssertTrue(
            Board(width: 0, height: 0).intersectsLeft(with: piece),
            "Piece I on first col does not intersect with left border"
        )
    }

    func testNotIntersectsLeftWithBorder() {
        var piece = I()
        piece.build(width: 0, height: 0)
        for _ in 0..<5 {
            piece.moveDown()
        }

        XCTAssertFalse(
            Board(width: 0, height: 0).intersectsLeft(with: piece),
            "Piece I intersects left on empty board from middle of screen"
        )
    }

    func testIntersectsLeftWithSquaresOnBoard() {
        var board = Board(width: 0, height: 0)
        board.walkAllSlots { row, col in
            if col != 3 { return }
            board.grid[row][col] = Square(row: row, col: col)
        }

        var piece = I()
        piece.build(width: 0, height: 0)
        for _ in 0..<5 {
            piece.moveDown()
        }

        XCTAssertTrue(
            board.intersectsLeft(with: piece),
            "Piece I not intersects with squares on left from board"
        )
    }

    func testIntersectsBottomWithBorder() {
        var piece = O()
        piece.build(width: 0, height: 0)
        for _ in 0..<17 {
            piece.moveDown()
        }

        XCTAssertTrue(
            Board(width: 0, height: 0).intersectsBottom(with: piece),
            "Piece O does not intersect to bottom on last row on empty board"
        )
    }

    func testIntersectsBottomWithSquaresOnBoard() {
        var board = Board(width: 0, height: 0)
        board.walkSlots(15..<board.numRows) { row, col in
            board.grid[row][col] = Square(row: row, col: col)
        }

        var piece = O()
        piece.build(width: 0, height: 0)
        for _ in 0..<12 {
            piece.moveDown()
        }

        XCTAssertTrue(
            board.intersectsBottom(with: piece),
            "Piece O does not intersect to bottom above squares"
        )
    }

    func testIntersectsRight() {
        var board = Board(width: 0, height: 0)
        board.walkAllSlots { row, col in
            if col != 5 { return }
            board.grid[row][col] = Square(row: row, col: col)
        }

        var piece = I()
        piece.build(width: 0, height: 0)
        for _ in 0..<5 {
            piece.moveDown()
        }

        XCTAssertTrue(
            board.intersects(with: piece.rotated),
            "Piece I can rotate with squares on right from board"
        )
    }

    func testIntersectsLeft() {
        var board = Board(width: 0, height: 0)
        board.walkAllSlots { row, col in
            if col != 3 { return }
            board.grid[row][col] = Square(row: row, col: col)
        }

        var piece = I()
        piece.build(width: 0, height: 0)
        for _ in 0..<5 {
            piece.moveDown()
        }

        XCTAssertTrue(
            board.intersects(with: piece.rotated),
            "Piece I can rotate with squares on left from board"
        )
    }
}
