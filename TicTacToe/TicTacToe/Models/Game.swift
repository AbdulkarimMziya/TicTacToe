//
//  Game.swift
//  TicTacToe
//
//  Created by Abdulkarim Mziya on 2026-03-27.
//

import Foundation

enum Player {
    case X
    case O
}

enum GameStatus {
    case Ongoing
    case Win(Player)
    case Draw
}

// MARK: Game Struct
struct Game {
    var currentPlayer: Player
    var board: [Player?]
    var gameStatus: GameStatus
}
