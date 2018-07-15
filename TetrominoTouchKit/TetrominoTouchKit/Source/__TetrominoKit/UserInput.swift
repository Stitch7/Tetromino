//
//  UserInput.swift
//  TetrominoCore
//
//  Created by Christopher Reitz on 16/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

public protocol UserInput {
    var userInputDelegate: UserInputDelegate? { get set }
}

public protocol UserInputDelegate {
    func rotateLeft()
    func rotateRight()
    func moveLeft()
    func moveRight()
    func moveDown()
    func dropDown()
}
