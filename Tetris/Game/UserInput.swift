//
//  UserInput.swift
//  Tetris
//
//  Created by Christopher Reitz on 16/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

protocol UserInput {
    var piece: Piece? { get set }
    var delegate: UserInputDelegate? { get set }
}

protocol UserInputDelegate {
    func rotate()
    func moveLeft()
    func moveRight()
    func moveDown()
}
