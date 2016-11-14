//
//  UIColor+flatColors.swift
//  Tetris
//
//  Created by Christopher Reitz on 13/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

extension UIColor {

    class func hsb(_ h: CGFloat, _ s: CGFloat, _ b: CGFloat) -> UIColor {
        return UIColor(
            hue: h / 360.0,
            saturation: s / 100.0,
            brightness: b / 100.0, alpha: 1.0
        )
    }

    class var flatBlue: UIColor {
        return UIColor.hsb(224, 50, 63)
    }

    class var flatPurple: UIColor {
        return UIColor.hsb(253, 52, 77)
    }
    
    class var flatGreen: UIColor {
        return UIColor.hsb(145, 77, 80)
    }

    class var flatMint: UIColor {
        return UIColor.hsb(168, 86, 74)
    }

    class var flatYellow: UIColor {
        return UIColor.hsb(48, 99, 100)
    }

    class var flatOrange: UIColor {
        return UIColor.hsb(28, 85, 90)
    }

    class var flatRed: UIColor {
        return UIColor.hsb(6, 74, 91)
    }
}
