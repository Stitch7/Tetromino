//
//  GameOverView.swift
//  TetrominoTouch
//
//  Created by Christopher Reitz on 13/11/2016.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit
import LTMorphingLabel

class GameOverView: UIVisualEffectView {

    // MARK: - Properties

    let menu = Menu()

    var gameOverLabel: LTMorphingLabel = {
        let label = LTMorphingLabel()
        label.morphingEffect = .anvil
        label.font = UIFont.systemFont(ofSize: 44, weight: .ultraLight)
        label.textAlignment = .center
        label.backgroundColor = .clear

        return label
    }()

    var menuTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView. = false
        tableView.backgroundColor = .clear
        if #available(iOS 11, *) {
            tableView.separatorInset = .zero
        }

        return tableView
    }()

    var newHighScore = false {
        didSet {
            // TODO: launch the rocket
        }
    }

    // MARK: - Initializers

    init() {
        super.init(effect: UIBlurEffect(style: .light))

        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        isHidden = true
        menuTableView.delegate = self
        menuTableView.dataSource = menu
    }

    func configureSubviews() {
        let vibrancyView = UIVisualEffectView(effect: effect)
        vibrancyView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vibrancyView)
        let contentViews = ["vibrancyView": vibrancyView]
        contentView.addConstraints(format: "V:|[vibrancyView]|", views: contentViews)
        contentView.addConstraints(format: "H:|[vibrancyView]|", views: contentViews)

        vibrancyView.contentView.addSubview(menuTableView)

        let vibrancyViews = ["menuTableView": menuTableView]


        var padding = 0
        if let superviewWidth = superview?.frame.width {
            padding = Int(superviewWidth * (20 * 0.01))
        }

        vibrancyView.addConstraints(format: "V:|-[menuTableView]-|", views: vibrancyViews)
        vibrancyView.addConstraints(format: "H:|-(\(padding))-[menuTableView]-(\(padding))-|", views: vibrancyViews)
    }
}

extension GameOverView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        gameOverLabel.frame = CGRect(x: 0, y: 0, width: menuTableView.frame.size.width, height: 100)

        let viewHeight: CGFloat = frame.height
        let tableViewContentHeight: CGFloat = menuTableView.contentSize.height
        var marginHeight: CGFloat = (viewHeight - tableViewContentHeight) / 2.0
        marginHeight -= 100
        menuTableView.contentInset = UIEdgeInsetsMake(marginHeight, 50, -marginHeight, 50)

        return gameOverLabel
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menuCell = menu.cells[indexPath.row] as? MenuCell {
            return menuCell.height
        }

        return 40
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let menuCell = self.menu.cells[indexPath.row] as? MenuCell {
            menuCell.clicked()
        }
    }

}

protocol MenuCell {
    var height: CGFloat { get }
    var clicked: () -> () { get }
}

class MenuCellButton: UITableViewCell, MenuCell {

    var height: CGFloat = 40
    var clicked: () -> ()

    required init(text: String, clicked: @escaping () -> ()) {
        self.clicked = clicked
        super.init(style: .default, reuseIdentifier: nil)

        selectionStyle = .none
        backgroundColor = .clear

        textLabel?.text = text
        textLabel?.textAlignment = .center
        textLabel?.textColor = tintColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MenuCellScoreSlider: UITableViewCell, MenuCell {

    var height: CGFloat = 60
    let label = UILabel()

    var clicked: () -> () = {

    }

    required init() {
        super.init(style: .default, reuseIdentifier: nil)

        backgroundColor = .clear

        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 5

        stackView.translatesAutoresizingMaskIntoConstraints = false

        label.font = UIFont.systemFont(ofSize: 15)
        scoreStepperChanged()

        let stepper = UIStepper()
        stepper.addTarget(self, action: #selector(scoreStepperChanged(sender:)), for: .touchUpInside)
        stepper.minimumValue = 0
        stepper.maximumValue = 10
        stepper.transform = CGAffineTransform(scaleX: 0.70, y: 0.70)

        stackView.addArrangedSubview(label)
//        stackView.addArrangedSubview(levelLabel)
        stackView.addArrangedSubview(stepper)

//        stepper.addVerticallyCenteredConstraints(inSuperView: container)
////        container.addConstraints(format: "V:|[slider]|", views: ["slider": stepper])
////        container.addConstraints(format: "H:|-40-[slider]-40-", views: ["slider": stepper])

        contentView.addSubview(stackView)
        stackView.addHorizontallyCenteredConstraints(inSuperView: contentView)
        stackView.addVerticallyCenteredConstraints(inSuperView: contentView)
//        contentView.addConstraints(format: "H:|[stackView]", views: ["stackView": stackView])
//        contentView.addConstraints(format: "V:|-[stackView]", views: ["stackView": stackView])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func scoreStepperChanged(sender: UIStepper? = nil) {
        label.text = "Start Level: \(Int(sender?.value ?? 0))"
    }
}

protocol MenuDelegate {
    func menuButtonPressed(button: MenuCellButton)
}

class Menu: NSObject, UITableViewDataSource {

    var cells = [UITableViewCell]()

    override init() {
        cells.append(MenuCellButton(text: "New Game", clicked: {
            print("YO")
        }))
        cells.append(MenuCellButton(text: "Highscore", clicked: {
            print("WER WIRD SIEGER SEIN?")
        }))
        cells.append(MenuCellScoreSlider())
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cells[indexPath.row]
        return cell
    }
}
