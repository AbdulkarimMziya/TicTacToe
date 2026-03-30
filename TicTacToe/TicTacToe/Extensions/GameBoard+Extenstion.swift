//
//  GameBoard+Extenstion.swift
//  TicTacToe
//
//  Created by Abdulkarim Mziya on 2026-03-27.
//

import UIKit

// MARK: Collection DataSource
extension GameboardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return board.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BoardCell
        
        let player = board[indexPath.item]
        
        cell.setSymbol(player)
        cell.backgroundColor = .systemGray2
        cell.layer.cornerRadius = 8
        
        return cell
    }

    
    
}


// MARK: Collection Layout
extension GameboardViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let sideLength = collectionView.bounds.width
        let totalSpacing = cellSpacing * 2 // Two gaps between three cells
        let itemSize = (sideLength - totalSpacing) / 3
                
        return CGSize(width: itemSize, height: itemSize)
    }
}


// MARK: Cell Interactions
extension GameboardViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 1. Check if the cell is already occupied locally
        guard board[indexPath.item] == nil else { return }
        
        // 2. Prevent human moves if it's currently the Opponent's (AI) turn
        guard manager.game.currentPlayer == .X else { return }
        
        // Trigger the Manager to make move
        manager.makeMove(at: indexPath.item)
        
    }
}


// MARK: GameManager Delegate
extension GameboardViewController: GameManagerDelegate {
    
    func gameDidStart(with player: Player) {
        // Update the local board property
        self.board = manager.game.board
        
        // Display Player turn
        switch player {
        case .X:
            displayLable.text = "Player X start!!!"
            displayLable.textColor = .neonBlue
        case .O:
            displayLable.text = "Opponent start!!!"
            displayLable.textColor = .neonRed
        }
        
        // Show the restart and exit buttons before player makes move
        hBtnStack.isHidden = false
    }
    
    func gameDidEnd(winner: Player) {
        // Update the local board property
        self.board = manager.game.board
        
        // Display relevant UI
        // Update Scores
        switch winner {
        case .X:
            displayLable.text = "Player X Won!!!"
            displayLable.textColor = .neonBlue
            
            scoreboard.updateScore(for: .player, to: manager.playerXScore)
        case .O:
            displayLable.text = "Opponents Won!!!"
            displayLable.textColor = .neonRed
            
            scoreboard.updateScore(for: .opponent, to: manager.playerOScore)
        }
        
        // Show the restart and exit buttons
        hBtnStack.isHidden = false
    }
    
    func playerDidChange(to player: Player) {
        self.board = manager.game.board
        
        // Display Player turn
        switch player {
        case .X:
            displayLable.text = "Player X turn!!!"
            displayLable.textColor = .neonBlue
        case .O:
            displayLable.text = "Opponents turn!!!"
            displayLable.textColor = .neonRed
        }
        
        // Hide the restart and exit buttons after first move
        hBtnStack.isHidden = true
    }
    
    func gameDidDraw() {
        // Update the local board property
        self.board = manager.game.board
        
        displayLable.text = "It's a Draw!"
        displayLable.textColor = .systemGray
        
        // Show the restart and exit buttons
        hBtnStack.isHidden = false
    }
    
    
}
