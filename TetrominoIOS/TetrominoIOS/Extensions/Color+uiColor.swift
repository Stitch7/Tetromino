//
//  Color+uiColor.swift
//  TetrominoTouch
//
//  Created by Christopher Reitz on 04/12/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit
import TetrominoCoreIOS

public extension Color {
    var uiColor: UIColor {
        let hsb = self.hsb
        return UIColor(
            hue: hsb.h / 360.0,
            saturation: hsb.s / 100.0,
            brightness: hsb.b / 100.0,
            alpha: 1.0
        )
    }
}
