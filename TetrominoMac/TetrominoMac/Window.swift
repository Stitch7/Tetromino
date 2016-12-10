//
//  Window.swift
//  TetrominoMac
//
//  Created by Christopher Reitz on 03/12/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import Cocoa
import TetrominoMacKit

class Window: NSWindow, UserInput {
    
    // MARK: - UserInput

    var userInputDelegate: UserInputDelegate?

    override func keyDown(with event: NSEvent) {
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
        default:
            super.keyDown(with: event)
        }
    }

    func zoom1MenuItemPressed(_ sender: Any) {
        Swift.print("zoom 1")
    }

    func zoom2MenuItemPressed(_ sender: Any) {
        Swift.print("zoom 2")
    }

    func zoom3MenuItemPressed(_ sender: Any) {
        Swift.print("zoom 3")
    }
}
