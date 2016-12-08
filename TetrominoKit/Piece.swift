//
//  Tetrimino.swift
//  TetrominoKit
//
//  Created by Christopher Reitz on 03/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import CoreGraphics

typealias Pattern = [[Bool]]

// MARK: - Piece

public struct Piece<ViewType: SquareViewType> {

    // MARK: - Properties

    public var type: PieceType
    public var squares = [Square<ViewType>]()

    var color: Color
    var pattern: Pattern
    var currentRow = 0
    var currentCol = 3

    var rotated: Piece<ViewType> {
        var rotated = self
        rotated.pattern = [
            [pattern[0][3], pattern[1][3], pattern[2][3], pattern[3][3]],
            [pattern[0][2], pattern[1][2], pattern[2][2], pattern[3][2]],
            [pattern[0][1], pattern[1][1], pattern[2][1], pattern[3][1]],
            [pattern[0][0], pattern[1][0], pattern[2][0], pattern[3][0]]
        ]
        let firstFrame = squares.first!.view.frame
        rotated.build(width: firstFrame.width, height: firstFrame.height)
        return rotated
    }

    // MARK: - Initializer

    init(type: PieceType, color: Color, pattern: Pattern) {
        self.type = type
        self.color = color
        self.pattern = pattern
    }

    // MARK: - Public

    mutating func build(width: CGFloat, height: CGFloat) {
        squares = [Square]()
        let rowCount = 4
        let colCount = 4
        for rowNo in 0..<rowCount {
            for colNo in 0..<colCount {
                guard pattern[rowNo][colNo] else { continue }
                let square = Square<ViewType>(
                    config: SquareViewConfig(
                        color: color,
                        boardRow: currentRow,
                        boardCol: currentCol,
                        pieceRow: rowNo,
                        pieceCol: colNo,
                        width: width,
                        height: height
                    )
                )
                squares.append(square)
            }
        }
    }

    mutating func moveLeft() {
        currentCol -= 1
        for square in squares {
            square.moveLeft()
        }
    }

    mutating func moveRight() {
        currentCol += 1
        for square in squares {
            square.moveRight()
        }
    }

    mutating func moveDown() {
        currentRow += 1
        for square in squares {
            square.moveDown()
        }
    }
}

// MARK: - PieceType

public enum PieceType {
    case I
    case J
    case L
    case O
    case S
    case T
    case Z
}

extension PieceType {
    var pattern: Pattern {
        switch self {
        case .I:
            return [[true, false, false, false],
                    [true, false, false, false],
                    [true, false, false, false],
                    [true, false, false, false]]
        case .J:
            return [[false, false, true, false],
                    [false, false, true, false],
                    [false, true, true, false],
                    [false, false, false, false]]
        case .L:
            return [[false, true, false, false],
                    [false, true, false, false],
                    [false, true, true, false],
                    [false, false, false, false]]
        case .O:
            return [[false, false, false, false],
                    [false, true, true, false],
                    [false, true, true, false],
                    [false, false, false, false]]
        case .S:
            return [[false, true, true, false],
                    [true, true, false, false],
                    [false, false, false, false],
                    [false, false, false, false]]
        case .T:
            return [[true, true, true, false],
                    [false, true, false, false],
                    [false, false, false, false],
                    [false, false, false, false]]
        case .Z:
            return [[true, true, false, false],
                    [false, true, true, false],
                    [false, false, false, false],
                    [false, false, false, false]]
        }
    }

    var color: Color {
        switch self {
        case .I: return .green
        case .J: return .purple
        case .L: return .blue
        case .O: return .red
        case .S: return .cyan
        case .T: return .yellow
        case .Z: return .orange
        }
    }

    func create<T: SquareViewType>() -> Piece<T> {
        return Piece<T>(
            type: self,
            color: color,
            pattern: pattern
        )
    }

    static func random<ViewType: SquareViewType>() -> Piece<ViewType> {
        let pieceIndex = 1 + ((arc4random_uniform(7) + 1) % 7)
        switch pieceIndex {
        case 1: return PieceType.I.create()
        case 2: return PieceType.J.create()
        case 3: return PieceType.L.create()
        case 4: return PieceType.O.create()
        case 5: return PieceType.S.create()
        case 6: return PieceType.T.create()
        case 7: return PieceType.Z.create()
        default: fatalError("Piece randomizer out of bounds")
        }
    }
}

extension PieceType: RawRepresentable {
    public typealias RawValue = String

    public init?(rawValue: RawValue) {
        switch rawValue {
        case "I": self = .I
        case "J": self = .J
        case "L": self = .L
        case "O": self = .O
        case "S": self = .S
        case "T": self = .T
        case "Z": self = .Z
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .I: return "I"
        case .J: return "J"
        case .L: return "L"
        case .O: return "O"
        case .S: return "S"
        case .T: return "T"
        case .Z: return "Z"
        }
    }
}
