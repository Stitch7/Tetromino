//
//  GameViewController.swift
//  Tetris
//
//  Created by Christopher Reitz on 02/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

final class GameViewController: UIViewController, GameDelegate {

    // MARK: - Properties

    var game: Game

    let interval: TimeInterval = 0.7
    var timer: Timer?
    var musicPlayer = MusicPlayer(music: .techno)
    let gameOverView = GameOverView()

    init(game: Game) {
        self.game = game
        super.init(nibName: nil, bundle: nil)
        game.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        configureApperance()
        configureNavigationBar()
        configureGameOverView()
//        musicPlayer.play()

        timer = Timer.scheduledTimer(
            timeInterval: interval,
            target: self,
            selector: #selector(mainLoop),
            userInfo: nil,
            repeats: true
        )
    }

    private func configureApperance() { 
        view.backgroundColor = .white
    }

    private func configureNavigationBar() {
        let scoreView = ScoreView()
        navigationItem.titleView = scoreView
        game.score.view = scoreView // TODO

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: LevelView())
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: NextPieceView())
    }

    private func configureGameOverView() {
        view.addSubview(gameOverView)
        let views =  ["gameOverView": gameOverView]
        addConstraints(format: "V:|[gameOverView]|", views: views)
        addConstraints(format: "H:|[gameOverView]|", views: views)
    }

    // MARK: - Main Loop

    func mainLoop() {
        game.tick()
    }

    // MARK: - GameDelegate

    func gameOver() {
        timer?.invalidate()
        gameOverView.newHighScore = game.score.save()
        view.bringSubview(toFront: gameOverView)
        gameOverView.isHidden = false
    }

    func mainView() -> UIView {
        return view
    }
}
