//
//  Color.swift
//  TetrominoCore
//
//  Created by Christopher Reitz on 04/12/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import CoreGraphics

public enum Color {
    case green
    case purple
    case blue
    case red
    case cyan
    case yellow
    case orange
}

public extension Color {
    var hsb: (h: CGFloat, s: CGFloat, b: CGFloat) {
        switch self {
        case .green:
            return (145, 77, 80)
        case .purple:
            return (253, 52, 77)
        case .blue:
            return (224, 50, 63)
        case .red:
            return (6, 74, 91)
        case .cyan:
            return (168, 86, 74)
        case .yellow:
            return (48, 99, 100)
        case .orange:
            return (28, 85, 90)
        }
    }
}
