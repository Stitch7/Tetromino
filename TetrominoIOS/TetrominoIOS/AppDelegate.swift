//
//  AppDelegate.swift
//  TetrominoTouch
//
//  Created by Christopher Reitz on 02/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit
import TetrominoCoreIOS

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    let screenBounds = UIScreen.main.bounds
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = initWindow(rootViewController: initRootViewController())
        return true
    }

    private func initRootViewController() -> UIViewController {
        let board = Board<SquareView>(width: screenBounds.width, height: screenBounds.height)
        let userInput = TouchUserInput()
        let game = Game<SquareView>(board: board, userInput: userInput, score: 0)
        let highscore = Highscore(userDefaults: UserDefaults.standard)
        let gameVC = GameViewController(game: game, userInput: userInput, highscore: highscore)
        let navigationController = UINavigationController(rootViewController: gameVC)

        return navigationController
    }

    private func initWindow(rootViewController: UIViewController) -> UIWindow {
        let window = UIWindow(frame: screenBounds)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()

        return window
    }
}
