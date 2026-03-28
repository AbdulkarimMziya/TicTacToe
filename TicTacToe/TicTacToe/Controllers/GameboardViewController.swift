//
//  GameboardViewController.swift
//  TicTacToe
//
//  Created by Abdulkarim Mziya on 2026-01-11.
//

import UIKit


class GameboardViewController: UIViewController {
    
    // MARK: UI Declarations
    lazy var boardView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "BoardCell")
        collection.backgroundColor = .systemGray2
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    // MARK: Controller Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(boardView)
        setupLayout()
        
    }
    
    // MARK: UI Constraints
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            // Board layout
            boardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            boardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            boardView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            boardView.heightAnchor.constraint(equalTo: boardView.widthAnchor)
        ])
        
    }
    
   



}






