//
//  GameboardView.swift
//  TicTacToe
//
//  Created by Abdulkarim Mziya on 2026-03-03.
//

import UIKit

// MARK: Gameboard View Class
class GameboardView: UIView {
    var cells: [[Cell]] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBoard()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBoard() {
        let boardStack = UIStackView()
        boardStack.axis = .vertical
        boardStack.spacing = 5
        boardStack.distribution = .fillEqually
        boardStack.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(boardStack)
        
        NSLayoutConstraint.activate([
            boardStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            boardStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            boardStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            boardStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        for row in 0..<3 {
            var rowCells: [Cell] = []
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 8
            rowStack.distribution = .fillEqually

            for col in 0..<3 {
                let cell = Cell(xPos: row, yPos: col)
                rowCells.append(cell)
                rowStack.addArrangedSubview(cell)
            }

            cells.append(rowCells)
            boardStack.addArrangedSubview(rowStack)
        }
    }
    
    func clearBoard() {
        
        for row in cells {
            
            for cell in row {
                cell.reset()
            }
        }
    }
    
}
