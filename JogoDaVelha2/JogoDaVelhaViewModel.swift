//
//  JogoDaVelhaViewModel.swift
//  JogoDaVelha2
//
//  Created by José Henrique Fernandes Silva on 29/01/24.
//

import Combine

enum Player: String {
    case first = "Primeiro"
    case second = "Segundo"
    case undefined = ""
}

enum GameBoardError: Error {
    case invalidPosition
    case notFreePosition
}

enum PositionType: String {
    case leftTop
    case leftCenter
    case leftBottom
    case midTop
    case midCenter
    case midBottom
    case rightTop
    case rightCenter
    case rightBottom
    case undefined
}

protocol GameBoardProtocol {
    mutating func update(position: PositionType, to player: Player) throws
    func getPositions(to selectedPlayer: Player) -> [PositionType]
    func getSelectPositionsCount() -> Int
    func getPlayer(to position: PositionType) -> Player
    mutating func resetBoard()
}

struct GameBoard: GameBoardProtocol {
    private var boardPositions: [PositionType: Player]
    
    init() {
        boardPositions = [
            .leftTop: .undefined, .midTop: .undefined, .rightTop: .undefined,
            .leftCenter: .undefined, .midCenter: .undefined, .rightCenter: .undefined,
            .leftBottom: .undefined, .midBottom: .undefined, .rightBottom: .undefined
        ]
    }
    
    func isUndefinedPosition(_ pos: PositionType) -> Bool {
        guard let position = boardPositions[pos] else { return false }
        if case .undefined = position {
            return true
        }
        return false
    }
    
    mutating func update(position: PositionType, to player: Player) throws {
        guard let boardPosition = boardPositions[position] else {
            throw GameBoardError.invalidPosition
        }
        
        switch boardPosition {
        case .undefined: boardPositions[position] = player
        default: throw GameBoardError.notFreePosition
        }
    }
    
    func getPositions(to selectedPlayer: Player) -> [PositionType] {
        var positions = [PositionType]()
        
        for (pos, player) in boardPositions {
            if selectedPlayer == player {
                positions.append(pos)
            }
        }
        
        return positions
    }
    
    func getSelectPositionsCount() -> Int {
        return boardPositions.reduce(0) { nextPartialResult, pos  in
            if pos.value != .undefined {
                return nextPartialResult + 1
            }
            return nextPartialResult
        }
    }
    
    func getPlayer(to position: PositionType) -> Player {
        guard let player = boardPositions[position] else {
            return .undefined
        }
        
        return player
    }
    
    mutating func resetBoard() {
        for (position, _) in boardPositions {
            boardPositions[position] = .undefined
        }
    }
}

class JogoDaVelhaViewModel: ObservableObject {
    
    // MARK: - PUBLIC PROPERTIES
    
    private(set) var currentPlayer: Player
    @Published var gameBoard: GameBoardProtocol
    @Published var selectedPosition: PositionType = .undefined
    @Published var isWinner = false
    @Published var oldWomanWinner = false
    @Published var firstPlayerScore = 0
    @Published var secondPlayerScore = 0
    @Published var oldWomanScore = 0
    
    // MARK: - INITIALIZER
    
    init(initialPlayer: Player = .first,
         gameBoard: GameBoardProtocol) {
        self.currentPlayer = initialPlayer
        self.gameBoard = gameBoard
    }
    
    // MARK: - PRIVATE METHODS
    
    private func checkIsWinner() -> Bool {
        let positions = gameBoard.getPositions(to: currentPlayer)
        
        guard positions.count >= 3 else { return false }
        
        if positions.contains(.leftTop),
           positions.contains(.leftCenter),
           positions.contains(.leftBottom) {
            return true
        }
        
        if positions.contains(.midTop),
           positions.contains(.midCenter),
           positions.contains(.midBottom) {
            return true
        }
        
        if positions.contains(.rightTop),
           positions.contains(.rightCenter),
           positions.contains(.rightBottom) {
            return true
        }
        
        if positions.contains(.leftTop),
           positions.contains(.midTop),
           positions.contains(.rightTop) {
            return true
        }
        
        if positions.contains(.leftCenter),
           positions.contains(.midCenter),
           positions.contains(.rightCenter) {
            return true
        }
        
        if positions.contains(.leftBottom),
           positions.contains(.midBottom),
           positions.contains(.rightBottom) {
            return true
        }
        
        if positions.contains(.leftTop),
           positions.contains(.midCenter),
           positions.contains(.rightBottom) {
            return true
        }
        
        if positions.contains(.rightTop),
           positions.contains(.midCenter),
           positions.contains(.leftBottom) {
            return true
        }
        
        return false
    }

    
    // MARK: - PUBLIC METHODS
    
    func playerTurn() -> Player {
        return currentPlayer
    }
    
    func updatePlayerTurn() {
        switch currentPlayer {
        case .first: currentPlayer = .second
        case .second: currentPlayer = .first
        case .undefined: break
        }
    }
    
    func setPlayerPosition() {
        do {
            try gameBoard.update(position: selectedPosition, to: currentPlayer)
            isWinner = checkIsWinner()
            oldWomanWinner = checkOldWomanIsWinner()
            shouldUpdatePlayerScore()
            shouldUpdateOldWomanScore()
            updatePlayerTurn()
        } catch {
            // TODO: Adicionar tratamento de error
        }
    }
    
    private func shouldUpdatePlayerScore() {
        guard isWinner else { return }
        switch currentPlayer {
        case .first: firstPlayerScore += 1
        case .second: secondPlayerScore += 1
        default: break
        }
    }
    
    private func shouldUpdateOldWomanScore() {
        guard oldWomanWinner else { return }
        oldWomanScore += 1
    }
    
    func setSelectPosition(_ position: PositionType) {
        selectedPosition = position
        setPlayerPosition()
    }
    
    func checkOldWomanIsWinner() -> Bool {
        guard !isWinner else { return false }
        return gameBoard.getSelectPositionsCount() >= 9
    }
    
    func getOldWomanWinnerMessage() -> String {
        return "Deu velha!"
    }
    
    func getWinnerMessage() -> String {
        var playerName = ""
        
        switch currentPlayer {
        case .first: playerName = "Primeiro"
        case .second: playerName = "Segundo"
        case .undefined: break
        }
        
        return "O \(playerName) jogador venceu!"
    }
}
