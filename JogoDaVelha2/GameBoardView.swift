//
//  GameBoardView.swift
//  JogoDaVelha2
//
//  Created by José Henrique Fernandes Silva on 01/02/24.
//

import SwiftUI

struct GameBoardView: View {
    
    @Binding var gameBoard: GameBoardProtocol
    
    var boardPlaceSelectCompletion: (_ position: PositionType) -> Void
    
    var body: some View {
        VStack {
            HStack {
                BoardPlace(gameBoard: $gameBoard,
                           position: .leftTop,
                           selectedPlaceCompletion: boardPlaceSelectCompletion)
                BoardPlace(gameBoard: $gameBoard,
                           position: .midTop,
                           selectedPlaceCompletion: boardPlaceSelectCompletion)
                BoardPlace(gameBoard: $gameBoard,
                           position: .rightTop,
                           selectedPlaceCompletion: boardPlaceSelectCompletion)
            }
            
            HStack {
                BoardPlace(gameBoard: $gameBoard,
                           position: .leftCenter,
                           selectedPlaceCompletion: boardPlaceSelectCompletion)
                BoardPlace(gameBoard: $gameBoard,
                           position: .midCenter,
                           selectedPlaceCompletion: boardPlaceSelectCompletion)
                BoardPlace(gameBoard: $gameBoard,
                           position: .rightCenter,
                           selectedPlaceCompletion: boardPlaceSelectCompletion)
            }
            
            HStack {
                BoardPlace(gameBoard: $gameBoard,
                           position: .leftBottom,
                           selectedPlaceCompletion: boardPlaceSelectCompletion)
                BoardPlace(gameBoard: $gameBoard,
                           position: .midBottom,
                           selectedPlaceCompletion: boardPlaceSelectCompletion)
                BoardPlace(gameBoard: $gameBoard,
                           position: .rightBottom,
                           selectedPlaceCompletion: boardPlaceSelectCompletion)
            }
        }
        .frame(height: 300)
        .background(Color.gray)
    }
}

#Preview {
    GameBoardView(gameBoard: .constant(GameBoard()),
                  boardPlaceSelectCompletion: {_ in})
}
