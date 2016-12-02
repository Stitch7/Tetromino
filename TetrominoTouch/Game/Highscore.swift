//
//  Highscore.swift
//  TetrominoTouch
//
//  Created by Christopher Reitz on 15/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import Foundation.NSUserDefaults

final class Highscore {

    // MARK: - Properties

    let userDefaults: UserDefaults
    let key = "highscore"

    var list = [Int]()
    var leader: Int {
        return list.sorted(by: { $0 > $1 }).first ?? 0
    }

    // MARK: - Initializers

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        if let savedHighScore = userDefaults.array(forKey: key) as? [Int] {
            self.list = savedHighScore
        }
    }

    // MARK: - Public

    func save(value: Int) -> Bool {
        let highscoreNotFull = list.count < 10
        let highscoreEntriesLowerThanCurrentScore = list.filter({ $0 < value }).count > 0

        if highscoreNotFull {
            list.append(value)
            userDefaults.set(list, forKey: key)
            return true
        }

        if highscoreEntriesLowerThanCurrentScore {
            // TODO: delete pending > 10
            list.append(value)
            userDefaults.set(list, forKey: key)
            return true
        }

        return false
    }
}
