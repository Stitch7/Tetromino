//
//  AppDelegate.swift
//  TetrominoTouchKitExample
//
//  Created by Christopher Reitz on 08.07.18.
//  Copyright © 2018 Christopher Reitz. All rights reserved.
//

import UIKit
import TetrominoTouchKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let screenBounds = UIScreen.main.bounds
        window = UIWindow(frame: screenBounds)

        let gameController = TetrominoTouch().makeGameController(bounds: screenBounds)
        window?.rootViewController = gameController
        window?.makeKeyAndVisible()

        return true
    }
}
