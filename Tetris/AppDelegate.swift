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
        configureWindow()
        return true
    }

    private func configureWindow() {
        let tetris = Game(score: Score())
        let highscore = Highscore(userDefaults: UserDefaults.standard)
        let gameVC = GameViewController(game: tetris, highscore: highscore)
        let tapGesture = UITapGestureRecognizer(target: nil, action: nil)
        tapGesture.delegate = tetris
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.addGestureRecognizer(tapGesture)
        window?.rootViewController = UINavigationController(rootViewController: gameVC)
        window?.makeKeyAndVisible()
    }
}
