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
        var board = Board()
        // complete the last 4 rows by placing squares in all cols
        let last4Rows = Board.numRows-4..<Board.numRows
        board.walkSlots(last4Rows) { row, col in
            board.grid[row][col] = Square(row: row, col: col)
        }
        assert(board.completedRows.count == 4)

        // test if no complete row remains after `killCompletedRows`
        board.killCompletedRows()
        XCTAssert(
            board.completedRows.count == 0,
            "Completed rows remaining after killCompletedRows"
        )
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
        XCTAssertFalse(
            noSquaresFoundInLastRow,
            "Squares didn't move down"
        )
    }

    func testIntersectsRightWithBorder() {
        var piece = I()
        piece.build()
        for _ in 0..<5 {
            piece.moveDown()
        }
        for _ in 0..<5 {
            piece.moveRight()
        }

        XCTAssertTrue(
            Board().intersectsRight(with: piece),
            "Piece I on last col does not intersect with right border"
        )
    }

    func testNotIntersectsRightWithBorder() {
        var piece = I()
        piece.build()
        for _ in 0..<5 {
            piece.moveDown()
        }

        XCTAssertFalse(
            Board().intersectsRight(with: piece),
            "Piece I intersects right on empty board from middle of screen"
        )
    }

    func testIntersectsRightWithSquaresOnBoard() {
        var board = Board()
        board.walkSlots { row, col in
            if col != 5 { return }
            board.grid[row][col] = Square(row: row, col: col)
        }

        var piece = I()
        piece.build()
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
        piece.build()
        for _ in 0..<5 {
            piece.moveDown()
        }
        for _ in 0..<4 {
            piece.moveLeft()
        }

        XCTAssertTrue(
            Board().intersectsLeft(with: piece),
            "Piece I on first col does not intersect with left border"
        )
    }

    func testNotIntersectsLeftWithBorder() {
        var piece = I()
        piece.build()
        for _ in 0..<5 {
            piece.moveDown()
        }

        XCTAssertFalse(
            Board().intersectsLeft(with: piece),
            "Piece I intersects left on empty board from middle of screen"
        )
    }

    func testIntersectsLeftWithSquaresOnBoard() {
        var board = Board()
        board.walkSlots { row, col in
            if col != 3 { return }
            board.grid[row][col] = Square(row: row, col: col)
        }

        var piece = I()
        piece.build()
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
        piece.build()
        for _ in 0..<17 {
            piece.moveDown()
        }

        XCTAssertTrue(
            Board().intersectsBottom(with: piece),
            "Piece O does not intersect to bottom on last row on empty board"
        )
    }

    func testIntersectsBottomWithSquaresOnBoard() {
        var board = Board()
        board.walkSlots(15..<Board.numRows) { row, col in
            board.grid[row][col] = Square(row: row, col: col)
        }

        var piece = O()
        piece.build()
        for _ in 0..<12 {
            piece.moveDown()
        }

        XCTAssertTrue(
            board.intersectsBottom(with: piece),
            "Piece O does not intersect to bottom above squares"
        )
    }

    func testIntersectsRight() {
        var board = Board()
        board.walkSlots { row, col in
            if col != 5 { return }
            board.grid[row][col] = Square(row: row, col: col)
        }

        var piece = I()
        piece.build()
        for _ in 0..<5 {
            piece.moveDown()
        }

        XCTAssertTrue(
            board.intersects(with: piece.rotated),
            "Piece I can rotate with squares on right from board"
        )
    }

    func testIntersectsLeft() {
        var board = Board()
        board.walkSlots { row, col in
            if col != 3 { return }
            board.grid[row][col] = Square(row: row, col: col)
        }

        var piece = I()
        piece.build()
        for _ in 0..<5 {
            piece.moveDown()
        }

        XCTAssertTrue(
            board.intersects(with: piece.rotated),
            "Piece I can rotate with squares on left from board"
        )
    }
}
