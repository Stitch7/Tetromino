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
        let game = Game<SquareView>(board: board)
        window.userInputDelegate = game
        let highscore = Highscore(userDefaults: UserDefaults.standard)
        viewController = GameViewController(game: game, userInput: window, highscore: highscore)
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        configureMainMenu()
        window.contentView!.addSubview(viewController.view)
        window.delegate = windowController
        windowController.showWindow(self)
    }

    func configureMainMenu() {
        let mainMenu = NSApplication.shared().mainMenu!
        let viewMenuItem = mainMenu.item(at: 1)

        let zoom1MenuItem = viewMenuItem!.submenu!.item(at: 2)!
        zoom1MenuItem.target = window
        zoom1MenuItem.action = #selector(window.zoom1MenuItemPressed)
        let zoom2MenuItem = viewMenuItem!.submenu!.item(at: 3)!
        zoom2MenuItem.target = window
        zoom2MenuItem.action = #selector(window.zoom2MenuItemPressed)
        let zoom3MenuItem = viewMenuItem!.submenu!.item(at: 4)!
        zoom3MenuItem.target = window
        zoom3MenuItem.action = #selector(window.zoom3MenuItemPressed)
    }
}
