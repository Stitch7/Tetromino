//
//  Input.swift
//  TetrominoCurses
//
//  Created by Christopher Reitz on 11/12/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import Foundation

final class Input: UserInput {

    // MARK: - UserInput

    var userInputDelegate: UserInputDelegate?

    // MARK: - Public

    private func keyDown(char: Int32) -> Bool {
        guard let game = userInputDelegate as? Game<SquareView> else { return false }
        guard let gameVC = game.delegate as? GameViewController else { return false }

        switch char {
        // Enter
        case 10:
            if game.gameOver {
                game.newGame()
            }

        // Cursor Left + h
        case 260: fallthrough
        case Int32(UnicodeScalar("h").value):
            if game.gameOver || game.board.intersectsLeft(with: game.currentPiece) { break }
            gameVC.wm.redrawGameWindow(board: game.board) { (window) in
                self.userInputDelegate?.moveLeft()
            }

        // Cursor Down + j
        case 258: fallthrough
        case Int32(UnicodeScalar("j").value):
            if game.gameOver || game.board.intersectsBottom(with: game.currentPiece) { break }
            gameVC.wm.redrawGameWindow(board: game.board) { (window) in
                self.userInputDelegate?.moveDown()
            }

        // Cursor UP + k
        case 259: fallthrough
        case Int32(UnicodeScalar("k").value):
            userInputDelegate?.rotate()

        // Cursor Right + l
        case 261: fallthrough
        case Int32(UnicodeScalar("l").value):
            if game.gameOver || game.board.intersectsRight(with: game.currentPiece) { break }
            gameVC.wm.redrawGameWindow(board: game.board) { (window) in
                self.userInputDelegate?.moveRight()
            }

        // Space
        case 32:
            if game.gameOver { break }
            gameVC.wm.redrawGameWindow(board: game.board) { (window) in
                self.userInputDelegate?.dropDown()
            }

        // ESQ + q
        case 27: fallthrough
        case Int32(UnicodeScalar("q").value):
            return false

        default:
            break
        }

        return true
    }

    // MARK: - Public

    func waitForInput() {
        var wait = true
        while wait {
            wait = keyDown(char: getch())
        }
    }
}
