//
//  Level.swift
//  Tetromino
//
//  Created by Christopher Reitz on 15/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import Foundation.NSDate

public enum Level: Int {
    case one
    case two
    case three
    case four
    case five
    case sixth
    case seven
    case nine
}

public extension Level {
    var number: Int {
        return self.rawValue + 1
    }

    var speed: TimeInterval {
        switch self {
        case .one:
            return 0.7
        case .two:
            return 0.6
        case .three:
            return 0.5
        case .four:
            return 0.4
        case .five:
            return 0.35
        case .sixth:
            return 0.3
        case .seven:
            return 0.25
        case .nine:
            return 0.2
        }
    }
}
