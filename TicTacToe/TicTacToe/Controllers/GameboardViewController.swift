//
//  GameboardViewController.swift
//  TicTacToe
//
//  Created by Abdulkarim Mziya on 2026-01-11.
//

import UIKit

// MARK: Gameboard View Controller
class GameboardViewController: UIViewController, GameManagerDelegate {
    private var playerScore = 0
    private var opponentScore = 0
    private var drawScore = 0

    
    let gameManager = GameManager()
    
    var scoreBoard = ScoreBoardView()
    
    let boardView = GameboardView()
    var currentPlayer: Cell.CellSymbol = .x
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Player X Turn"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .center
        label.textColor = .neonBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var restartButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Play Again", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        gameManager.delegate = self
        
        scoreBoard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scoreBoard)
        
        NSLayoutConstraint.activate([
            scoreBoard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            scoreBoard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreBoard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scoreBoard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scoreBoard.heightAnchor.constraint(equalToConstant: 88)
        ])

        
        boardView.translatesAutoresizingMaskIntoConstraints = false
        boardView.backgroundColor = .darkCardBG
        boardView.layer.cornerRadius = 16
        boardView.clipsToBounds = false
        boardView.layer.shadowColor = UIColor.black.cgColor
        boardView.layer.shadowOpacity = 0.3
        boardView.layer.shadowRadius = 12
        boardView.layer.shadowOffset = CGSize(width: 0, height: 6)
        view.addSubview(boardView)
        
        NSLayoutConstraint.activate([
            boardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            boardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            boardView.widthAnchor.constraint(equalToConstant: 300),
            boardView.heightAnchor.constraint(equalToConstant: 300)
        ])

        
        for row in boardView.cells {
            for cell in row {
                cell.configureTap(target: self, action: #selector(cellTapped(_:)))
            }
        }
        
        view.addSubview(statusLabel)

        NSLayoutConstraint.activate([
            statusLabel.bottomAnchor.constraint(equalTo: boardView.topAnchor, constant: -16),
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        
        view.addSubview(restartButton)
        
        NSLayoutConstraint.activate([
            restartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            restartButton.topAnchor.constraint(equalTo: boardView.bottomAnchor, constant: 40)
        ])
        restartButton.addTarget(self, action: #selector(restartTapped), for: .touchUpInside)

    }
    
    @objc
    private func cellTapped(_ sender: Cell){
        guard sender.isEnabled else { return }
        
        sender.setSymbol(gameManager.currentPlayer)
        
        // switch turn
        gameManager.makeMove(
            x: sender.xPos,
            y: sender.yPos
        )

        print("Tapped cell at (\(sender.xPos), \(sender.yPos))")
    }
    
    @objc
    private func restartTapped() {
        gameManager.resetGame()
        
    }
    
    func gameDidEnd(result: GameManager.GameResult) {
        setBoardEnabled(false)

        switch result {
        case .win(let winner):
            if winner == .x {
                playerScore += 1
                scoreBoard.updateScore(for: .player, to: playerScore)
                statusLabel.text = "Player X Wins!"
                statusLabel.textColor = .neonBlue
            } else {
                opponentScore += 1
                scoreBoard.updateScore(for: .opponent, to: opponentScore)
                statusLabel.text = "Opponent O Wins!"
                statusLabel.textColor = .neonRed
            }

        case .draw:
            drawScore += 1
            scoreBoard.updateScore(for: .draw, to: drawScore)
            statusLabel.text = "It's a Draw"
            statusLabel.textColor = .systemGray

        case .ongoing:
            break
        }
    }

    func playerDidChange(to player: Cell.CellSymbol) {
        switch player {
        case .x:
            statusLabel.text = "Player X Turn"
            statusLabel.textColor = .neonBlue
        case .o:
            statusLabel.text = "Opponent O Turn"
            statusLabel.textColor = .neonRed
        case .empty:
            break
        }
    }
    
    func gameDidReset() {
        boardView.clearBoard()
        setBoardEnabled(true)
        statusLabel.text = "Player X Turn"
        statusLabel.textColor = .neonBlue
    }

    
    private func setBoardEnabled(_ enabled: Bool) {
        for row in boardView.cells {
            for cell in row {
                cell.isEnabled = enabled
            }
        }
    }




}






