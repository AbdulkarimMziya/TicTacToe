//
//  GameManagerDelegate.swift
//  TicTacToe
//
//  Created by Abdulkarim Mziya on 2026-03-03.
//

import Foundation

// MARK: Game Delegate Protocol
protocol GameManagerDelegate: AnyObject {
    func gameDidEnd(result: GameManager.GameResult)
    func playerDidChange(to player: Cell.CellSymbol)
    func gameDidReset()
}
