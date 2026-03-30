//
//  ViewController.swift
//  TicTacToe
//
//  Created by Abdulkarim  on 12/29/25.
//

import UIKit

class ViewController: UIViewController {
    
    private var gameTitle: UILabel = {
        let label = UILabel()
        label.text = "Ultimate Tic Tac Toe"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var startbutton: UIButton = {
        let btn = UIButton(type: .system)
        
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        var config = UIButton.Configuration.tinted()
        config.attributedTitle = AttributedString("Start Game", attributes: container)
        config.baseBackgroundColor = .green
        config.baseForegroundColor = .green
        config.buttonSize = .large
        config.titlePadding = 4
        
        btn.configuration = config
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let settingsButton: UIButton = {
        let btn = UIButton()
        var config = UIButton.Configuration.tinted()
        config.title = "Settings"
        config.image = UIImage(systemName: "gearshape.fill")
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .systemBlue
        config.buttonSize = .large
        config.imagePadding = 4
        
        btn.configuration = config
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .darkGreyBG
        
        view.addSubview(gameTitle)
        view.addSubview(startbutton)
        view.addSubview(settingsButton)
        
        NSLayoutConstraint.activate([
            gameTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            startbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startbutton.topAnchor.constraint(equalTo: gameTitle.bottomAnchor, constant: 32),
            
            settingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsButton.topAnchor.constraint(equalTo: startbutton.bottomAnchor, constant: 40)
        ])
        
        
        startbutton.addTarget(self, action: #selector(startGameTapped), for: .touchUpInside)
        
        settingsButton.addTarget(self, action: #selector(didTapSettings), for: .touchUpInside)

    }
    
    @objc
    private func startGameTapped() {
        let gameVC = GameboardViewController()
        navigationController?.pushViewController(gameVC, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: false)

    }
    
    @objc
    private func didTapSettings() {
        let settingsVC = SettingsViewController()
        
        // Wrap in a Nav Controller if you want a title bar/Done button
        let nav = UINavigationController(rootViewController: settingsVC)
        
        // Use .pageSheet for the modern iOS "pull-down to dismiss" look
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium()] // Only takes up half the screen
            sheet.prefersGrabberVisible = true // Adds the little handle at the top
        }
        
        present(nav, animated: true)
    }

    
    
}




