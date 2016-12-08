//
//  AppDelegate.swift
//  TetrominoMac
//
//  Created by Christopher Reitz on 03/12/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import AppKit
import TetrominoMacKit

class AppDelegate: NSObject, NSApplicationDelegate {

    let screenBounds = NSMakeRect(0, 0, 480, 960)
    var window: Window
    var windowController: WindowController
    var viewController: GameViewController

    override init() {
        window = Window(
            contentRect: screenBounds,
            styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        window.setFrameAutosaveName(Bundle.main.bundleIdentifier!)
        window.makeKeyAndOrderFront(window)

        Bundle.main.loadNibNamed("MainMenu", owner: app, topLevelObjects: nil)
        windowController = WindowController(window: window)

        let board = Board<SquareView>(width: screenBounds.width, height: screenBounds.height)
        let game = Game<SquareView>(board: board, userInput: window, score: 0)
        let highscore = Highscore(userDefaults: UserDefaults.standard)
        viewController = GameViewController(game: game, userInput: window, highscore: highscore)
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window.contentView!.addSubview(viewController.view)
        window.delegate = windowController
        windowController.showWindow(self)
    }
}
