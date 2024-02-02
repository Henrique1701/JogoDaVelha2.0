//
//  GameBoardMock.swift
//  JogoDaVelha2Tests
//
//  Created by José Henrique Fernandes Silva on 30/01/24.
//

@testable import JogoDaVelha2

class GameBoardMock: GameBoardProtocol {
    private(set) var updateCalled = false
    private(set) var updatePassedPosition: PositionType?
    private(set) var updatePassedPlayer: Player?
    private(set) var getPositionsCalled = false
    private(set) var getPositionsPassedPlayer: Player?
    
    var updateToBeReturn: GameBoardError?
    var getPositionsToBeReturn: [PositionType]?
    
    func update(position: JogoDaVelha2.PositionType, to player: JogoDaVelha2.Player) throws {
        updateCalled = true
        updatePassedPosition = position
        updatePassedPlayer = player
        
        if let updateToBeReturn {
            throw updateToBeReturn
        }
    }
    
    func getPositions(to selectedPlayer: JogoDaVelha2.Player) -> [JogoDaVelha2.PositionType] {
        getPositionsCalled = true
        getPositionsPassedPlayer = selectedPlayer
        
        return getPositionsToBeReturn ?? []
    }
    
    func getSelectPositionsCount() -> Int {
        // TODO: Implementar spy properties
        return 0
    }
    
    func getPlayer(to position: JogoDaVelha2.PositionType) -> JogoDaVelha2.Player {
        // TODO: Implementar spy properties
        return .undefined
    }
    
    func resetBoard() {
        // TODO: Implementar spy properties
    }
}
