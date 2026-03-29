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
    
    let restartButton: UIButton = {
        let btn = UIButton()
        
        var config = UIButton.Configuration.tinted()
        config.title = "Play Again"
        config.baseBackgroundColor = .systemGreen
        config.baseForegroundColor = .systemGreen
        config.titlePadding = 4
        config.buttonSize = .large
        config.cornerStyle = .capsule
        
        btn.configuration = config
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let exitButton: UIButton = {
        let btn = UIButton()
        
        var config = UIButton.Configuration.tinted()
        config.title = "Exit"
        config.baseBackgroundColor = .neonRed
        config.baseForegroundColor = .neonRed
        config.titlePadding = 4
        config.buttonSize = .large
        config.cornerStyle = .capsule
        
        btn.configuration = config
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var hBtnStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [restartButton,exitButton])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.isHidden = true
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: Controller Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(boardView)
        view.addSubview(displayLable)
        view.addSubview(hBtnStack)
        setupLayout()
        
        // btn target functions
        restartButton.addTarget(self, action: #selector(didTapRestartBtn), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(didTapExitBtn), for: .touchUpInside)
        
        // Collection delegates
        boardView.dataSource = self
        boardView.delegate = self
        
        // GameManager delegate
        manager.delegate = self
        manager.startGame()
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
            displayLable.bottomAnchor.constraint(equalTo: boardView.topAnchor, constant: -8),
            
            // HStack Layout
            hBtnStack.topAnchor.constraint(equalTo: boardView.bottomAnchor, constant: 32),
            hBtnStack.leadingAnchor.constraint(equalTo: boardView.leadingAnchor),
            hBtnStack.trailingAnchor.constraint(equalTo: boardView.trailingAnchor)
        ])
        
    }
    
    @objc
    func didTapRestartBtn() {
        manager.resetGame()
    }
    
    @objc
    func didTapExitBtn() {
        navigationController?.popViewController(animated: true)
    }
    

}






