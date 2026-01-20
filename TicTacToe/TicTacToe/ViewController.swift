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
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var startbutton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Start Game", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(gameTitle)
        view.addSubview(startbutton)
        
        NSLayoutConstraint.activate([
            gameTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            startbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startbutton.topAnchor.constraint(equalTo: gameTitle.bottomAnchor, constant: 32),
        ])
        
        startbutton.addTarget(self, action: #selector(startGameTapped), for: .touchUpInside)

    }
    
    @objc
    private func startGameTapped() {
        let gameVC = GameboardViewController()
        navigationController?.pushViewController(gameVC, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: false)

    }

    
    
}




