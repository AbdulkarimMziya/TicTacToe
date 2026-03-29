//
//  GameboardViewController.swift
//  TicTacToe
//
//  Created by Abdulkarim Mziya on 2026-01-11.
//

import UIKit


class GameboardViewController: UIViewController {
    
    // MARK: Class Properties
    let manager = GameManager()
    
    lazy var board = manager.game.board {
        didSet {
            boardView.reloadData()
        }
    }
    
    let cellId = "BoardCell"
    let cellSpacing = 4.0
    
    // MARK: UI Declarations
    lazy var boardView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collection.backgroundColor = .darkCardBG
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    let displayLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 24, weight: .bold)
        lable.textColor = .white
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    // MARK: Controller Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(boardView)
        view.addSubview(displayLable)
        setupLayout()
        
        // Collection delegates
        boardView.dataSource = self
        boardView.delegate = self
        
        // GameManager delegate
        manager.delegate = self
    }
    
    // MARK: UI Constraints
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            // Board layout
            boardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            boardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            boardView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            boardView.heightAnchor.constraint(equalTo: boardView.widthAnchor),
            
            // DisplayLable layout
            displayLable.centerXAnchor.constraint(equalTo: boardView.centerXAnchor),
            displayLable.bottomAnchor.constraint(equalTo: boardView.topAnchor, constant: -8)
        ])
        
    }
    

}






