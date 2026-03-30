//
//  Cell.swift
//  TicTacToe
//
//  Created by Abdulkarim Mziya on 2026-03-03.
//

import UIKit

// MARK: Custom Board Cell Class
class BoardCell: UICollectionViewCell {
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 64, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.backgroundColor = .systemGray2
        contentView.layer.cornerRadius = 8
        contentView.addSubview(symbolLabel)
        
        NSLayoutConstraint.activate([
            symbolLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            symbolLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func setSymbol(_ newSymbol: Player?) {
        guard let symbol = newSymbol else {
            symbolLabel.text = ""
            return
        }
        
        symbolLabel.text = (symbol == .X) ? "X" : "O"
        symbolLabel.textColor = (symbol == .X) ? .neonBlue : .neonRed
    }
}
