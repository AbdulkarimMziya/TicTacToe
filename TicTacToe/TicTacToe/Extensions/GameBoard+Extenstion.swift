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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        let playerSymbol = board[indexPath.item]
        
        switch playerSymbol{
        case .X:
            cell.backgroundColor = .neonBlue
        case .O:
            cell.backgroundColor = .neonRed
        default:
            cell.backgroundColor = .systemGray2
        }
        
        
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
        
        // Trigger the Manager to make move
        manager.makeMove(at: indexPath.item)
        
        // Update board - trigger reload
        //board = manager.game.board
        
        print("Cell \(indexPath.item) triggered")
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
        
        // Hide the restart and exit buttons
        hBtnStack.isHidden = true
    }
    
    func gameDidEnd(winner: Player) {
        // Update the local board property
        self.board = manager.game.board
        
        // Display relevant UI
        switch winner {
        case .X:
            displayLable.text = "Player X Won!!!"
            displayLable.textColor = .neonBlue
        case .O:
            displayLable.text = "Opponents Won!!!"
            displayLable.textColor = .neonRed
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
    }
    
    func gameDidDraw() {
        // Update the local board property
        self.board = manager.game.board
        
        // Show the restart and exit buttons
        hBtnStack.isHidden = false
    }
    
    
}
