//
//  TetrominoTouch.swift
//  TetrominoTouchKit
//
//  Created by Christopher Reitz on 07.07.18.
//  Copyright © 2018 Christopher Reitz. All rights reserved.
//

public class TetrominoTouch {

    public init() {
    }

    public func makeGameController(bounds: CGRect) -> UINavigationController {
        var bottomOffset: CGFloat = 0.0;
        if #available(iOS 11.0, *) {
            bottomOffset = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0;
        }

        let boardHeight = bounds.height - bottomOffset
        let board = Board<SquareView>(width: bounds.width, height: boardHeight)


        let userInput = TouchUserInput()
        let game = Game<SquareView>(board: board, userInput: userInput, score: 0)
        let highscore = Highscore(userDefaults: UserDefaults.standard)
        let gameVC = GameViewController(game: game, userInput: userInput, highscore: highscore)
        let navigationController = UINavigationController(rootViewController: gameVC)

        return navigationController
    }
}
