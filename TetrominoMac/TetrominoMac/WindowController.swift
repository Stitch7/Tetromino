//
//  WindowController.swift
//  TetrominoMac
//
//  Created by Christopher Reitz on 03/12/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import AppKit
import TetrominoMacKit

class WindowController: NSWindowController, NSWindowDelegate {

    // MARK: - Properties

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

    // MARK: - Views

    var levelTextField: NSTextField = {
        let textField = NSTextField()
        textField.cell = LevelTextFieldCell()
        textField.wantsLayer = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isEditable = false
        textField.isBezeled = false
        textField.font = NSFont.systemFont(ofSize: 16.0, weight: NSFontWeightLight)
        return textField
    }()

    var scoreTextField: NSTextField = {
        let textField = NSTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.drawsBackground = false
        textField.isEditable = false
        textField.isBezeled = false
        textField.font = NSFont.systemFont(ofSize: 28.0, weight: NSFontWeightThin)
        textField.alignment = .center
        return textField
    }()

    var levelToolbarItem: NSToolbarItem = {
        let toolbarItem = NSToolbarItem(itemIdentifier: "LevelView")
        toolbarItem.maxSize = CGSize(width: 80, height: 30)
        return toolbarItem
    }()

    var scoreToolbarItem: NSToolbarItem = {
        let toolbarItem = NSToolbarItem(itemIdentifier: "ScoreView")
        toolbarItem.maxSize = CGSize(width: 290, height: 30)
        return toolbarItem
    }()

    var nextPieceToolbarItem: NSToolbarItem = {
        let toolbarItem = NSToolbarItem(itemIdentifier: "NextPieceView")
        toolbarItem.label = "Next"
        toolbarItem.maxSize = CGSize(width: 100, height: 30)
        return toolbarItem
    }()

    var toolbarItems = [NSToolbarItem]()

    // MARK: - Initializers

    override init(window: NSWindow?) {
        super.init(window: window)
        configureToolbar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    func configureToolbar() {
        levelToolbarItem.view = levelTextField
        scoreToolbarItem.view = scoreTextField

        toolbarItems = [
            levelToolbarItem,
            scoreToolbarItem,
            NSToolbarItem(itemIdentifier: NSToolbarFlexibleSpaceItemIdentifier),
            nextPieceToolbarItem
        ]

        let toolbar = NSToolbar(identifier: "Game")
        toolbar.delegate = self
        window?.toolbar = toolbar
    }
}

extension WindowController: NSToolbarDelegate {
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [String] {
        var identifiers = [String]()
        for (i, _) in toolbarItems.enumerated() {
            identifiers.append("\(i)")
        }
        return identifiers
    }

    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: String, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        return toolbarItems[Int(itemIdentifier)!]
    }

    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [String] {
        return toolbarDefaultItemIdentifiers(toolbar)
    }

    func toolbarSelectableItemIdentifiers(_ toolbar: NSToolbar) -> [String] {
        return toolbarDefaultItemIdentifiers(toolbar)
    }
}
