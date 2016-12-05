//
//  UserInput.swift
//  Tetromino
//
//  Created by Christopher Reitz on 16/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

public protocol UserInput {
    var piece: Piece? { get set }
    var userInputDelegate: UserInputDelegate? { get set }
}

public protocol UserInputDelegate {
    func rotate()
    func moveLeft()
    func moveRight()
    func moveDown()
    func dropDown()
}
