//
//  GameManager.swift
//  TicTacToe
//
//  Created by Abdulkarim Mziya on 2026-03-03.
//

import Foundation

enum Difficulty {
    case easy, medium, hard
}

class GameManager {
    
    var game: Game
    
    weak var delegate: GameManagerDelegate?
    
    static var currentDifficulty: Difficulty = .medium
    
    var playerXScore = 0
    var playerOScore = 0
    
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
            
            // If .O make AI make move
            if game.currentPlayer == .O {
                makeAIMove()
            }
            
            // Update Delegate of turns
            delegate?.playerDidChange(to: game.currentPlayer)
        case .Win(_):
            game.gameStatus = gameStatus
            
            // Update score
            if currentPlayer == .X {
                playerXScore += 1
            } else {
                playerOScore += 1
            }
            
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
        startGame()
    }
    
    func makeAIMove() {
        // find all empy spots
        let board = game.board
        let availableSpots = board.indices.filter({board[$0] == nil})
        
        let aiMove: Int?
        
        // Pick move according to difficulty selected:
        switch GameManager.currentDifficulty {
        case .easy:
            aiMove = availableSpots.randomElement()
        case .medium:
            aiMove = getMediumAIMove(availableSpots)
        case .hard:
            aiMove = getHardAIMove(availableSpots)
        }
        
        if let pos = aiMove {
            // Delay move then execute
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.makeMove(at: pos)
            }
        }
    
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
        
        // If AI starts, trigger the first move
        if game.currentPlayer == .O {
            makeAIMove()
        }
    }
    
    // MARK: AI Helper Methods
    
    // Medium AI
    func getMediumAIMove(_ availableSpots: [Int]) -> Int? {
        let humanPlayer: Player = .X
        
        // 1. If AI can win, then win
        if let winMove = findWinningMove(for: .O) {
            return winMove
        }
        // 2. If AI can block, then block
        if let blockMove = findBlockMove(for: humanPlayer) {
            return blockMove
        }
        
        // 3. otherwise, select random position
        return availableSpots.randomElement()
    }
    
    // Hard AI
    func getHardAIMove(_ availableSpots: [Int]) -> Int? {
        let humanPlayer: Player = .X
        
        // 1. If AI can win, then win
        if let winMove = findWinningMove(for: .O) {
            return winMove
        }
        
        // 2. If AI can block, then block
        if let blockMove = findBlockMove(for: humanPlayer) {
            return blockMove
        }
        
        // 3. If AI can't block, then take center
        if availableSpots.contains(4) {
            return 4 // index of center
        }
        
        // 4. otherwise, select random position
        return availableSpots.randomElement()
    }
    
    func findWinningMove(for player: Player) -> Int? {
        let currentBoardState = game.board
        
        for pos in currentBoardState.indices where currentBoardState[pos] == nil {
            var tempBoard = currentBoardState
            tempBoard[pos] = player
            
            // If move results in a win, return index
            if case .Win = checkGameStatus(tempBoard, for: player) {
                return pos
            }
            
        }
        return nil
    }
    
    func findBlockMove(for player: Player) -> Int? {
        return findWinningMove(for: player)
    }
   
}
