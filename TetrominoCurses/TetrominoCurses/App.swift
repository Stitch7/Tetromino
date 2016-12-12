//
//  App.swift
//  TetrominoCurses
//
//  Created by Christopher Reitz on 12/12/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import Foundation

final class App {

    // MARK: - Properties

    let userInput = Input()
    let wm: WindowManager
    let viewController: GameViewController

    // MARK: - Initializers

    init() {
        let board = Board<SquareView>()
        let game = Game<SquareView>(board: board)
        userInput.userInputDelegate = game
        wm = WindowManager(game: game)

        let highscore = Highscore(userDefaults: UserDefaults.standard)
        viewController = GameViewController(wm: wm, userInput: userInput, highscore: highscore)
    }

    // MARK: - Public

    func run(completionHandler: (() -> Void)? = nil) {
        wm.run(userInput: userInput)
        completionHandler?()
    }
}
