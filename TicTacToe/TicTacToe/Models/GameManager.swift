//
//  GameManager.swift
//  TicTacToe
//
//  Created by Abdulkarim Mziya on 2026-03-03.
//

import Foundation


class GameManager {
    
    var game: Game
    
    weak var delegate: GameManagerDelegate?
    
    init() {
        let player:Player = Bool.random() ? .X : .O
        
        game = Game(currentPlayer: player,
                    board: Array(repeating: nil, count: 9),
                    gameStatus: .Ongoing
        )
    }
    
    // MARK: Methods
    
    func makeMove(at index:Int) {
        // Make move if the game is 'Ongoing'
        guard case .Ongoing = game.gameStatus else {
            return
        }
        
        // Allow move if index is empty
        guard game.board[index] == nil else {
            return
        }
        
        let currentPlayer = game.currentPlayer
        
        // Place the current Player symbol at position
        game.board[index] = currentPlayer
        
        // Check for Winner
        let gameStatus = checkGameStatus(game.board, for: currentPlayer)
        
        switch(gameStatus) {
        case .Ongoing:
            // Switch turn to other Player
            game.gameStatus = gameStatus
            game.currentPlayer = currentPlayer == .X ? .O : .X
            
            // Update Delegate of turns
            delegate?.playerDidChange(to: game.currentPlayer)
        case .Win(_):
            game.gameStatus = gameStatus
            
            // Update Delegate Game ends and reset
            delegate?.gameDidEnd(winner: currentPlayer)
        case .Draw:
            // Game Resets
            game.gameStatus = gameStatus
            
            // Update Delegate to reset
            delegate?.gameDidDraw()
    
        }


    }
    
    func resetGame() {
        let player:Player = Bool.random() ? .X : .O
        
        game = Game(currentPlayer: player,
                    board: Array(repeating: nil, count: 9),
                    gameStatus: .Ongoing
        )

        // Update Delegate New Game
        delegate?.gameDidStart(with: player)
    }
    
    
    // MARK: Helper Functions
    func checkGameStatus(_ board: [Player?], for currentPlayer:Player) -> GameStatus {
        
        let winningPatterns = [
            [0,1,2], [3,4,5], [6,7,8], // rows
            [0,3,6], [1,4,7], [2,5,8], // columns
            [0,4,8], [2,4,6]           // diagonals
        ]
        
        for pattern in winningPatterns {
            if pattern.allSatisfy({ board[$0] == currentPlayer }) {
                return .Win(currentPlayer)
            }
        }

        // Check for draws
        if !board.contains(nil) {
            return GameStatus.Draw
        }

        
        
        return GameStatus.Ongoing
    }
    
    func startGame() {
        delegate?.gameDidStart(with: game.currentPlayer)
    }
   
}
