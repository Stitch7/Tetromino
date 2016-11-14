//
//  Score.swift
//  Tetris
//
//  Created by Christopher Reitz on 13/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import Foundation

struct Score {

    // MARK: - Properties

    let userDefaults: UserDefaults
    let key = "highscore"

    var view: ScoreView?
    var highScore: [Int]
    var currentScore = 0 {
        didSet {
            view?.score = currentScore

        }
    }
    var number1Score: Int {
        return highScore.sorted(by: { $0 < $1 }).first ?? 0
    }

    // MARK: - Initializers

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        self.highScore = [Int]()
        if let savedHighScore = userDefaults.array(forKey: key) as? [Int] {
            self.highScore = savedHighScore
            self.view?.highscoreValue.text = "\(number1Score)"
        }
    }

    mutating func add(numberOfRows: Int) {
        var score = numberOfRows * 100
        if numberOfRows == 4 {
            score += 100
        }
        currentScore += score
    }

    mutating func save() -> Bool {
        let highscoreNotFull = highScore.count < 10
        let highscoreEntriesLowerThanCurrentScore = highScore.filter({ $0 < self.currentScore })

        if highscoreNotFull {
            highScore.append(currentScore)
            userDefaults.set(highScore, forKey: key)
            return true
        } else if highscoreEntriesLowerThanCurrentScore.count > 0 {
            // TODO delete
            highScore.append(currentScore)
            userDefaults.set(highScore, forKey: key)
            return true
        }
        return false
    }
}
