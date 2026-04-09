# Ultimate Tic Tac Toe

> A sleek, neon-themed iOS Tic Tac Toe game built with SwiftUI and UIKit - featuring a tiered AI opponent, a dynamic scoreboard, and a fully programmatic modern UI.

![iOS 15.0+](https://img.shields.io/badge/iOS-15.0%2B-blue?style=flat-square)
![Xcode 15.0+](https://img.shields.io/badge/Xcode-15.0%2B-147EFB?style=flat-square&logo=xcode)
![Swift 5.9+](https://img.shields.io/badge/Swift-5.9%2B-F05138?style=flat-square&logo=swift)

---

## Features

- **Three AI Difficulty Modes** - Easy (Random), Medium (Heuristic), and Hard (Positional Advantage)
- **Dynamic Scoreboard** - Tracks player and opponent wins across sessions with a glowing neon UI
- **Modern Programmatic UI** - Built entirely with AutoLayout, `UICollectionView`, and `UIButton.Configuration`
- **Delegate-Driven Architecture** - Game rules are fully decoupled from the visual interface
- **Smart Game Loop** - AI auto-triggers, "thinking" delays for realism, and anti-double-tap move validation

---

## Requirements

| Tool  | Version |
|-------|---------|
| iOS   | 15.0+   |
| Xcode | 15.0+   |
| Swift | 5.9+    |

---

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/AbdulkarimMziya/TicTacToe.git
cd TicTacToe
```

### 2. Open and run the app

Open `TicTacToe.xcodeproj` in Xcode, select an iOS Simulator or connected device, and press **Run** (`⌘R`).

---

## Architecture

The project follows a decoupled **MVC** pattern with a strong emphasis on the **Delegate Pattern** for cross-layer communication.

```
TicTacToe/
├── Controllers/
│   ├── GameboardViewController.swift   # Core gameplay and CollectionView logic
│   ├── SettingsViewController.swift    # Modal sheet for difficulty selection
│   └── ViewController.swift            # Home screen with navigation and branding
├── Extensions/
│   ├── ColorExtension.swift            # Custom neon color palette
│   └── GameBoard+Extension.swift       # GameBoard helper extensions
├── Models/
│   ├── Game.swift                      # Snapshot of board, player, and status
│   ├── GameManager.swift               # The "Brain": AI logic, win-checking, and state
│   └── GameManagerDelegate.swift       # Communication bridge between logic and UI
├── Views/
│   ├── Cell.swift                      # Custom cell for rendering X and O symbols
│   └── ScoreBoardView.swift            # Custom view for session score tracking
└── Support/
    ├── AppDelegate.swift
    ├── SceneDelegate.swift
    └── Assets.xcassets
```

### Key Components

| Component | Responsibility |
|-----------|----------------|
| `GameManager` | Enforces rules, runs AI heuristics, and manages the win-check algorithm |
| `GameboardViewController` | Handles user input and reacts to `GameManager` events via delegate methods |
| `GameManagerDelegate` | Notifies the UI when a player moves, a winner is found, or the game resets |
| `ScoreBoardView` | A modular UI component that displays and updates current match scores |
| `Cell` | Manages the visual state of individual board tiles using high-contrast typography |

---

## AI Difficulty Levels

| Level | Strategy |
|-------|----------|
| **Easy** | Selects a random empty cell |
| **Medium** | Tries to win immediately; otherwise blocks the player's winning move |
| **Hard** | Medium logic + Center Control - prioritizes index 4 (middle square) for a tactical edge |

---

## License

This project is available under the MIT License. See `LICENSE` for details.
