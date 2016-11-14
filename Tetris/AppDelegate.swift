//
//  AppDelegate.swift
//  Tetris
//
//  Created by Christopher Reitz on 02/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    typealias LaunchOptions = [UIApplicationLaunchOptionsKey: Any]?

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: LaunchOptions) -> Bool {
        configureWindow()
        return true
    }

    func configureWindow() {
        let gameVC = GameViewController()
        let tapGesture = UITapGestureRecognizer(target: nil, action: nil)
        tapGesture.delegate = gameVC
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.addGestureRecognizer(tapGesture)
        window?.rootViewController = UINavigationController(rootViewController: gameVC)
        window?.makeKeyAndVisible()
    }
}
