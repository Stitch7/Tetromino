//
//  Window.swift
//  TetrominoMac
//
//  Created by Christopher Reitz on 03/12/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import Cocoa
import TetrominoCoreMac

class Window: NSWindow, UserInput {

    // MARK: - UserInput

    var userInputDelegate: UserInputDelegate?

    override func keyUp(with event: NSEvent) {
    }

    override func keyDown(with event: NSEvent) {
        super.keyDown(with: event)

        switch event.keyCode {
        case 49: // space
            userInputDelegate?.dropDown()
        case 123: // left
            userInputDelegate?.moveLeft()
        case 124: // right
            userInputDelegate?.moveRight()
        case 125: // down
            userInputDelegate?.moveDown()
        case 126: // up
            userInputDelegate?.rotate()
        default: break
        }
    }
}
