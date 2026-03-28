//
//  GameboardViewController.swift
//  TicTacToe
//
//  Created by Abdulkarim Mziya on 2026-01-11.
//

import UIKit


class GameboardViewController: UIViewController {
    
    // MARK: Class Properties
    let cellSpacing = 4.0
    
    // MARK: UI Declarations
    lazy var boardView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "BoardCell")
        collection.backgroundColor = .darkCardBG
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    // MARK: Controller Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(boardView)
        setupLayout()
        
        // Collection delegates
        boardView.dataSource = self
        boardView.delegate = self
        
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






