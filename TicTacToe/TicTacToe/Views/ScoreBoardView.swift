//
//  ScoreBoardView.swift
//  TicTacToe
//
//  Created by Abdulkarim Mziya on 2026-03-03.
//

import UIKit

// MARK: Scoreboard Class
class ScoreBoardView: UIView {
    
    enum Player {
        case player, draw, opponent

        var title: String {
            switch self {
                case .player: return "Player X"
                case .draw: return "Draw"
                case .opponent: return "Opponent O"
            }
        }
    }
    
    private var scoreLabels: [Player: UILabel] = [:]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpScoreBoard()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpScoreBoard()
    }
    
    func setUpScoreBoard() {
        self.backgroundColor = .darkCardBG
        self.layer.cornerRadius = 16
        
        
        let card1 = makeScoreCard(for: .player)
        let card2 = makeScoreCard(for: .opponent)
        
        
        let row = UIStackView(arrangedSubviews: [card1,card2])
        row.axis = .horizontal
        row.spacing = 8
        row.distribution = .fillEqually
        row.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(row)
        
        NSLayoutConstraint.activate([
            row.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            row.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            row.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            row.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])

    }
    
    private func makeScoreCard(for player: Player) -> UIView {
        
        let accentColor: UIColor
            switch player {
            case .player:
                accentColor = .neonBlue
            case .draw:
                accentColor = .systemGray
            case .opponent:
                accentColor = .neonRed
        }

        let container = UIView()
        container.backgroundColor = .darkCardBG
        container.layer.cornerRadius = 16
        container.clipsToBounds = false
        container.layer.borderWidth = 1.5
        container.layer.borderColor = accentColor.cgColor

        container.layer.shadowColor = accentColor.cgColor
        container.layer.shadowOpacity = 0.6
        container.layer.shadowRadius = 10
        container.layer.shadowOffset = .zero

        
        
        let nameLabel = UILabel()
        nameLabel.text = player.title
        nameLabel.textColor = accentColor
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        nameLabel.textAlignment = .center

        let scoreLabel = UILabel()
        scoreLabel.text = "0"
        scoreLabel.textColor = accentColor
        scoreLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        scoreLabel.textAlignment = .center
        
        scoreLabels[player] = scoreLabel
        
        let vStack = UIStackView(arrangedSubviews: [nameLabel, scoreLabel])
        vStack.axis = .vertical
        vStack.spacing = 8
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        
        container.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])

        return container
    }
    
    func updateScore(for player: Player, to score: Int) {
        guard let label = scoreLabels[player] else {
            print("DEBUG: label for \(player) DNE!!!")
            return
        }
        label.text = "\(score)"
    }
    
}

