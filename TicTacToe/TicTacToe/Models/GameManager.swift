//
//  GameManager.swift
//  TicTacToe
//
//  Created by Abdulkarim Mziya on 2026-03-03.
//

import Foundation

// MARK: Game Logic Implementation
class GameManager {
    
    weak var delegate: GameManagerDelegate?
    
    private var gameBoard: [[Cell.CellSymbol]]
    
    var currentPlayer = Cell.CellSymbol.x
    
    enum GameResult {
        case win(Cell.CellSymbol)
        case draw
        case ongoing
    }
    
    init() {
        self.gameBoard = Array(
            repeating: Array(repeating:.empty, count: 3),
            count: 3
        )
    }
    
    
    func makeMove(x:Int, y:Int) {
        gameBoard[x][y] = currentPlayer
        
        let result  = checkGameState()
        
        switch result {
            case .ongoing:
                currentPlayer = (currentPlayer == .x) ? .o : .x
                delegate?.playerDidChange(to: currentPlayer)

            case .win, .draw:
                delegate?.gameDidEnd(result: result)
        }
        
    }
    
    func checkGameState() -> GameResult {
        
        // Check Rows
        for row in 0..<3 {
            let first = gameBoard[row][0]

            // Skip empty rows
            if first == .empty { continue }

            if gameBoard[row][1] == first && gameBoard[row][2] == first {
                return .win(first)
            }
        }
        
        // Check columns
        for col in 0..<3 {
            let first = gameBoard[0][col]

            // Skip empty columns
            if first == .empty { continue }

            if gameBoard[1][col] == first && gameBoard[2][col] == first {
                return .win(first)
            }
        }
        
        // Check diagonals
        let center = gameBoard[1][1]

        if center != .empty {

            // Top-left to bottom-right
            if gameBoard[0][0] == center && gameBoard[2][2] == center {
                return .win(center)
            }

            // Top-right to bottom-left
            if gameBoard[0][2] == center && gameBoard[2][0] == center {
                return .win(center)
            }
        }
        
        // Check for draw
        for row in gameBoard {
            if row.contains(.empty) {
                return .ongoing
            }
        }
        
        return .draw
    }
    
    func resetGame() {
        gameBoard = Array(
            repeating: Array(repeating: .empty, count: 3),
            count: 3
        )

        currentPlayer = .x
        delegate?.gameDidReset()
        delegate?.playerDidChange(to: currentPlayer)
    }
   
}
