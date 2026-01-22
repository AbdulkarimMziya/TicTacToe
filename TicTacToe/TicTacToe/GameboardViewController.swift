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
                case .player: return "Player X"
                case .draw: return "Draw"
                case .opponent: return "Opponent O"
            }
        }
    }
    
    private var scoreLabels: [Player: UILabel] = [:]

    
    private let neonBlue = UIColor(red: 64/255, green: 216/255, blue: 255/255, alpha: 1)
    private let neonRed = UIColor(red: 255/255, green: 77/255, blue: 109/255, alpha: 1)
    private let darkCardBG = UIColor(red: 15/255, green: 24/255, blue: 40/255, alpha: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpScoreBoard()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpScoreBoard()
    }
    
    func setUpScoreBoard() {
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 16
        
        
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
                accentColor = neonBlue
            case .draw:
                accentColor = .systemGray
            case .opponent:
                accentColor = neonRed
        }

        let container = UIView()
        container.backgroundColor = darkCardBG
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
        self.backgroundColor = .systemTeal
        self.layer.cornerRadius = 5
        self.setTitle(symbol.rawValue, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 64, weight: .medium)
        self.setTitleColor(.black, for: .disabled)
    }
    
    func setSymbol(_ newSymbol: CellSymbol) {
        self.symbol = newSymbol

        self.setTitle(newSymbol.rawValue, for: .normal)
        self.isEnabled = newSymbol != .empty ? false : true
    }
    
    
    func reset() {
        setSymbol(.empty)
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
class GameboardViewController: UIViewController, GameManagerDelegate {
    private var playerScore = 0
    private var opponentScore = 0
    private var drawScore = 0

    
    let gameManager = GameManager()
    
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
        
        gameManager.delegate = self
        
        scoreBoard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scoreBoard)
        
        NSLayoutConstraint.activate([
            scoreBoard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            scoreBoard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreBoard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scoreBoard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scoreBoard.heightAnchor.constraint(equalToConstant: 88)
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
        guard sender.isEnabled else { return }
        
        sender.setSymbol(gameManager.currentPlayer)
        
        // switch turn
        gameManager.makeMove(
            x: sender.xPos,
            y: sender.yPos
        )

        print("Tapped cell at (\(sender.xPos), \(sender.yPos))")
    }
    
    @objc
    private func restartTapped() {
        gameManager.resetGame()
        
    }
    
    func gameDidEnd(result: GameManager.GameResult) {
        setBoardEnabled(false)
        
        switch result {
            case .win(let winner):
                if winner == .x {
                    playerScore += 1
                    scoreBoard.updateScore(for: .player, to: playerScore)
                } else {
                    opponentScore += 1
                    scoreBoard.updateScore(for: .opponent, to: opponentScore)
                }
                print("Winner:", winner)

            case .draw:
                drawScore += 1
                scoreBoard.updateScore(for: .draw, to: drawScore)
                print("Draw")

            case .ongoing:
                break
        }
    }

    func playerDidChange(to player: Cell.CellSymbol) {
        print("Current Player:", player)
    }
    
    
    func gameDidReset() {
        boardView.clearBoard()
        setBoardEnabled(true)
    }
    
    private func setBoardEnabled(_ enabled: Bool) {
        for row in boardView.cells {
            for cell in row {
                cell.isEnabled = enabled
            }
        }
    }




}


// MARK: Game Delegate Protocol
protocol GameManagerDelegate: AnyObject {
    func gameDidEnd(result: GameManager.GameResult)
    func playerDidChange(to player: Cell.CellSymbol)
    func gameDidReset()
}


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
