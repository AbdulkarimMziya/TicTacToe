//
//  SettingsViewController.swift
//  TicTacToe
//
//  Created by Abdulkarim Mziya on 2026-03-29.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let difficultySelector: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Easy", "Medium", "Hard"])
        sc.selectedSegmentIndex = {
            switch GameManager.currentDifficulty {
            case .easy: return 0
            case .medium: return 1
            case .hard: return 2
            }
        }()
        sc.selectedSegmentTintColor = .systemBlue
        sc.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground 
        title = "Game Settings"
        
        view.addSubview(difficultySelector)
        
        NSLayoutConstraint.activate([
            difficultySelector.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            difficultySelector.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            difficultySelector.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
        
        difficultySelector.addTarget(self, action: #selector(difficultyChanged), for: .valueChanged)
    }

    @objc private func difficultyChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: GameManager.currentDifficulty = .easy
        case 1: GameManager.currentDifficulty = .medium
        case 2: GameManager.currentDifficulty = .hard
        default: break
        }
    }
}

