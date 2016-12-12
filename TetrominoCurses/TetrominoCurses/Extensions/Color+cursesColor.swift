//
//  Color+cursesColor.swift
//  TetrominoCurses
//
//  Created by Christopher Reitz on 11/12/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import Foundation

extension Color {
    var cursesColor: Int32 {
        return COLOR_PAIR(self.rawValue + 1)
    }

    static var cursesBlackAndWhite: UInt32 {
        return UInt32(COLOR_PAIR(0))
    }

    static func initCurses() {
        start_color()
        init_pair(0, Int16(COLOR_WHITE), Int16(COLOR_BLACK))

        init_pair(1, Int16(COLOR_GREEN), Int16(COLOR_GREEN))
        init_pair(2, Int16(COLOR_MAGENTA), Int16(COLOR_MAGENTA))
        init_pair(3, Int16(COLOR_BLUE), Int16(COLOR_BLUE))
        init_pair(4, Int16(COLOR_RED), Int16(COLOR_RED))
        init_pair(5, Int16(COLOR_CYAN), Int16(COLOR_CYAN))
        init_pair(6, Int16(COLOR_YELLOW), Int16(COLOR_YELLOW))
        init_pair(7, Int16(COLOR_WHITE), Int16(COLOR_WHITE))
    }
}
