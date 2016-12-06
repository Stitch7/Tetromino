//
//  WindowController.swift
//  TetrominoMac
//
//  Created by Christopher Reitz on 03/12/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import Cocoa
import TetrominoCoreMac

class WindowController: NSWindowController {

    // MARK: - IBOutlets

    @IBOutlet weak var levelTextField: NSTextField!
    @IBOutlet weak var scoreToolbarItem: NSToolbarItem!
    @IBOutlet weak var scoreTextField: NSTextField!
    @IBOutlet weak var nextPieceToolbarItem: NSToolbarItem!

    // MARK: - Proprties

    var level: Level? {
        didSet {
            guard let newLevel = level else { return }
            levelTextField.stringValue = "Level \(newLevel.number)"
        }
    }

    var score: Score? {
        didSet {
            guard let newScore = score else { return }
            scoreTextField.stringValue = "Score \(newScore.value)"
        }
    }

    var highscore: Highscore? {
        didSet {
            guard let newHighscore = highscore else { return }
            scoreToolbarItem.label = "Highscore \(newHighscore.leader)"
        }
    }

    // MARK: - NSWindowController

    override func windowDidLoad() {
        super.windowDidLoad()

        window?.styleMask.insert(.fullSizeContentView)
        window?.setFrame(CGRect(x: 0, y: 0, width: 480, height: 960 + 22), display: true)
    }
}
