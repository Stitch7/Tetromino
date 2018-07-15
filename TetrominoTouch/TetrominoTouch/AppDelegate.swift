//
//  AppDelegate.swift
//  TetrominoTouch
//
//  Created by Christopher Reitz on 02/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit
import TetrominoTouchKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let screenBounds = UIScreen.main.bounds
        let gameController = TetrominoTouch().makeGameController(bounds: screenBounds)

        window = UIWindow(frame: screenBounds)
        window?.rootViewController = gameController
        window?.makeKeyAndVisible()

        return true
    }
}
