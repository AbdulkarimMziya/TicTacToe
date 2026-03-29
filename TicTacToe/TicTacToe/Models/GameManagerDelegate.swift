//
//  GameManagerDelegate.swift
//  TicTacToe
//
//  Created by Abdulkarim Mziya on 2026-03-03.
//

import Foundation

// MARK: Game Delegate Protocol
protocol GameManagerDelegate: AnyObject {
    func gameDidStart(with player: Player)
    func gameDidEnd(winner: Player)
    func playerDidChange(to player: Player)
    func gameDidDraw()
}
