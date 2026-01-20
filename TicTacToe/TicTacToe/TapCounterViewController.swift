//
//  Untitled.swift
//  TicTacToe
//
//  Created by Abdulkarim Mziya on 2026-01-11.
//

import UIKit

class TapCounterViewController: UIViewController {
    
    var count = 0
    
    var countLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var tapButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Tap Me", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(countLabel)
        view.addSubview(tapButton)
        
        NSLayoutConstraint.activate([
            countLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            
            tapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tapButton.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 50),
            
        ])
        
        tapButton.addTarget(self, action: #selector(increaseCounter), for: .touchUpInside)
        
    }
    
    @objc private func increaseCounter() {
        
        count += 1
        countLabel.text = "\(count)"
    }
}

