//
//  Cell.swift
//  TicTacToe
//
//  Created by Abdulkarim Mziya on 2026-03-03.
//

import UIKit

// MARK: Custom Board Cell Class
class Cell: UIButton {
    
    
    enum CellSymbol: String {
        case x = "X", o = "O", empty = ""
    }
    
    private var symbol: CellSymbol = .empty
    let xPos: Int
    let yPos: Int
    
    init(xPos: Int, yPos: Int) {
        self.xPos = xPos
        self.yPos = yPos
        super.init(frame: .zero)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        
        self.backgroundColor = UIColor(red: 20/255, green: 32/255, blue: 55/255, alpha: 1)
        self.layer.cornerRadius = 8
        self.setTitle(symbol.rawValue, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 64, weight: .medium)
        
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.clipsToBounds = false
        self.layer.borderWidth = 1.5
    }
    
    private func accentColor(for symbol: CellSymbol) -> UIColor {
        switch symbol {
        case .x:
            return .neonBlue
        case .o:
            return .neonRed
        case .empty:
            return .systemGray
        }
    }

    
    func setSymbol(_ newSymbol: CellSymbol) {
        self.symbol = newSymbol
        
        let accent = accentColor(for: newSymbol)

        self.setTitle(newSymbol.rawValue, for: .normal)
        self.setTitleColor(accent, for: .normal)
        
        self.isEnabled = newSymbol != .empty ? false : true
    }
    
    
    func reset() {
        setSymbol(.empty)
    }
    
    func configureTap(target: Any?, action: Selector) {
        addTarget(target, action: action, for: .touchUpInside)
    }

}
