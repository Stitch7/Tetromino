//
//  SquareView.swift
//  TetrominoCurses
//
//  Created by Christopher Reitz on 11/12/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import Darwin.ncurses
import Foundation

final class SquareView: SquareViewType {

    // MARK: - Properties

    var config: SquareViewConfig
    var window: WindowManager.Window?

    // MARK: - Initializers

    init(config: SquareViewConfig) {
        self.config = config
    }

    public func remove() {
    }

    func moveLeft() {
        config.boardCol -= 1
        draw(window: window, config: config)
    }

    func moveRight() {
        config.boardCol += 1
        draw(window: window, config: config)
    }

    func moveDown() {
        config.boardRow += 1
        draw(window: window, config: config)
    }

    func draw(window: OpaquePointer?, config: SquareViewConfig) {
        let color = config.color.cursesColor
        wattron(window, color)

        let row = (2 * Int32(config.boardRow + config.pieceRow) - 1) + 2
        let col = (4 * Int32(config.boardCol + config.pieceCol)) + 1

        mvwaddch(window, row, col + 0, UInt32(" "))
        mvwaddch(window, row, col + 1, UInt32(" "))
        mvwaddch(window, row, col + 2, UInt32(" "))
        mvwaddch(window, row, col + 3, UInt32(" "))

        mvwaddch(window, row + 1, col + 0, UInt32(" "))
        mvwaddch(window, row + 1, col + 1, UInt32(" "))
        mvwaddch(window, row + 1, col + 2, UInt32(" "))
        mvwaddch(window, row + 1, col + 3, UInt32(" "))

        wattroff(window, color)
    }
}
