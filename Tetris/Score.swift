//
//  Score.swift
//  Tetris
//
//  Created by Christopher Reitz on 13/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

protocol ScoreDelegate {
    func scoreDidUpdate(value: Int)
}

final class Score {

    // MARK: - Properties

    var delegate: ScoreDelegate?
    var value = 0 {
        didSet {
            self.delegate?.scoreDidUpdate(value: value)
        }
    }

    // MARK: - Initializers

    convenience init (value: Int) {
        self.init()
        self.value = value
    }

    // MARK: - Public

    func add(numberOfRows: Int) {
        var score = numberOfRows * 100
        if numberOfRows == 4 {
            score += 100
        }
        value += score
    }
}
