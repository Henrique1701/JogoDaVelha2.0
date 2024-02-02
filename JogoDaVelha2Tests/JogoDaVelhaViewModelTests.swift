//
//  JogoDaVelhaViewModelTests.swift
//  JogoDaVelha2Tests
//
//  Created by José Henrique Fernandes Silva on 29/01/24.
//

import XCTest
@testable import JogoDaVelha2

final class JogoDaVelhaViewModelTests: XCTestCase {
    
    var sut: JogoDaVelhaViewModel!
    var gameBoardMock: GameBoardMock!

    override func setUpWithError() throws {
        gameBoardMock = GameBoardMock()
        sut = JogoDaVelhaViewModel(gameBoard: gameBoardMock)
    }

    override func tearDownWithError() throws {
        gameBoardMock = nil
        sut = nil
    }
    
    func test_playerTurn_returnInitialPlayer() {
        XCTAssertEqual(sut.playerTurn(), .first)
    }
    
    func test_updatePlayerTurn() {
        let firstPlayerTurn = sut.playerTurn()
        
        sut.updatePlayerTurn()
        
        XCTAssertNotEqual(sut.playerTurn(), firstPlayerTurn)
    }
    
    func test_checkIsValidPosition() {
        XCTFail("Checar se é uma posição valida")
    }
    
    func test_checkWinner() {
        XCTFail("Checar qual é o jogador vencedor")
    }
}
