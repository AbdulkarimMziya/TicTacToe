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
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BoardCell", for: indexPath)
        
       
        cell.backgroundColor = .systemGray2
        
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
        
        print("Cell \(indexPath.item) Selected!!")
    }
}

