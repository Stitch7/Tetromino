//
//  AppDelegate.swift
//  Tetris
//
//  Created by Christopher Reitz on 02/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    typealias LaunchOptions = [UIApplicationLaunchOptionsKey: Any]?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: LaunchOptions) -> Bool {
        let userInput = TouchUserInput()
        let board = Board(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let game = Game(board: board, userInput: userInput, score: 0)
        let highscore = Highscore(userDefaults: UserDefaults.standard)

        let gameVC = GameViewController(game: game, userInput: userInput, highscore: highscore)
        let navigationController = UINavigationController(rootViewController: gameVC)

        let tapGesture = UITapGestureRecognizer(target: nil, action: nil)
        tapGesture.delegate = userInput

        self.window = configureWindow(rootVC: navigationController, gestureRecognizer: tapGesture)

        return true
    }

    private func configureWindow(rootVC: UIViewController, gestureRecognizer: UIGestureRecognizer) -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.addGestureRecognizer(gestureRecognizer)
        window.rootViewController = rootVC
        window.makeKeyAndVisible()

        return window
    }
}
