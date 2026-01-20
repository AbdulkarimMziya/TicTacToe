//
//  GameboardViewController.swift
//  TicTacToe
//
//  Created by Abdulkarim Mziya on 2026-01-11.
//

import UIKit

// MARK: Scoreboard Class
class ScoreBoardView: UIView {
    
    enum Player {
        case player, draw, opponent

        var title: String {
            switch self {
                case .player: return "Player"
                case .draw: return "Draw"
                case .opponent: return "Opponent"
            }
        }
    }
    
    private var scoreLabels: [Player: UILabel] = [:]

    
    private var label: UILabel = {
        let label = UILabel()
        label.text = "Scores"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpScoreBoard()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpScoreBoard()
    }
    
    func setUpScoreBoard() {
        self.backgroundColor = .systemGray5
        self.layer.cornerRadius = 5
        
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        let card = makeScoreCard(for: .player)
        let card1 = makeScoreCard(for: .draw)
        let card2 = makeScoreCard(for: .opponent)
        
        
        let row = UIStackView(arrangedSubviews: [card,card1,card2])
        row.axis = .horizontal
        row.spacing = 8
        row.distribution = .fillEqually
        row.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(row)
        
        NSLayoutConstraint.activate([
            row.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16),
            row.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            row.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            row.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        
        
    }
    
    private func makeScoreCard(for player: Player) -> UIView {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 5
        
        let nameLabel = UILabel()
        nameLabel.text = player.title
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center

        let scoreLabel = UILabel()
        scoreLabel.text = "0"
        scoreLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        scoreLabel.textColor = .black
        scoreLabel.textAlignment = .center
        
        scoreLabels[player] = scoreLabel
        
        let vStack = UIStackView(arrangedSubviews: [nameLabel, scoreLabel])
        vStack.axis = .vertical
        vStack.spacing = 5
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


// MARK: Custom Board Cell Class
class Cell: UIButton {
    
    enum CellSymbol {
        case empty, x, o
    }
    
    var symbol: CellSymbol = .empty
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
        self.backgroundColor = .systemTeal
        self.layer.cornerRadius = 5
        self.setTitle("", for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        
    }
    
    func setSymbol(_ newSymbol: CellSymbol) {
        guard symbol == .empty else { return }

        self.symbol = newSymbol

        self.setTitle(newSymbol == .x ? "X" : "O", for: .normal)
        self.isEnabled = false
        self.setTitleColor(.black, for: .disabled)
    }
    
    func reset() {
        symbol = .empty
        setTitle("", for: .normal)
        isEnabled = true
    }
    
    func configureTap(target: Any?, action: Selector) {
        addTarget(target, action: action, for: .touchUpInside)
    }

}

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
            boardStack.topAnchor.constraint(equalTo: topAnchor),
            boardStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            boardStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            boardStack.bottomAnchor.constraint(equalTo: bottomAnchor)
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

// MARK: Gameboard View Controller
class GameboardViewController: UIViewController {
    
    var scoreBoard = ScoreBoardView()
    
    let boardView = GameboardView()
    var currentPlayer: Cell.CellSymbol = .x
    
    private var restartButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Play Again", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        scoreBoard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scoreBoard)
        
        NSLayoutConstraint.activate([
            scoreBoard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            scoreBoard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreBoard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scoreBoard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scoreBoard.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        
        boardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(boardView)
        
        NSLayoutConstraint.activate([
            boardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            boardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            boardView.widthAnchor.constraint(equalToConstant: 300),
            boardView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        for row in boardView.cells {
            for cell in row {
                cell.configureTap(target: self, action: #selector(cellTapped(_:)))
            }
        }
        
        view.addSubview(restartButton)
        
        NSLayoutConstraint.activate([
            restartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            restartButton.topAnchor.constraint(equalTo: boardView.bottomAnchor, constant: 48),
        ])
        restartButton.addTarget(self, action: #selector(restartTapped), for: .touchUpInside)

    }
    
    @objc
    private func cellTapped(_ sender: Cell){
        sender.setSymbol(currentPlayer)
        
        // switch turn
        currentPlayer = (currentPlayer == .x) ? .o : .x

        print("Tapped cell at (\(sender.xPos), \(sender.yPos))")
    }
    
    @objc
    private func restartTapped() {
        boardView.clearBoard()
        
        currentPlayer = .x
    }

}
