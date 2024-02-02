//
//  JogoDaVelhaView.swift
//  JogoDaVelha2
//
//  Created by José Henrique Fernandes Silva on 29/01/24.
//

import SwiftUI

struct JogoDaVelhaView: View {
    
    @ObservedObject var viewModel: JogoDaVelhaViewModel
    
    init(viewModel: JogoDaVelhaViewModel) {
        self.viewModel = viewModel
    }
    
    private func getColor(to player: Player) -> Color {
        switch player {
        case .first: return .blue
        case .second: return .yellow
        case .undefined: return .gray
        }
    }
    
    private func getCurrentOpacity(to player: Player) -> Double {
        if viewModel.currentPlayer == player {
            return 1
        }
        return 0.2
    }
    
    @ViewBuilder
    private var firstPlayer: some View {
        Rectangle()
            .fill(Color.blue)
            .frame(width: 25, height: 25)
    }
    
    @ViewBuilder
    private var secondPlayer: some View {
        Rectangle()
            .fill(Color.yellow)
            .frame(width: 25, height: 25)
    }
    
    @ViewBuilder
    private var oldWoman: some View {
        Rectangle()
            .fill(Color.gray)
            .frame(width: 25, height: 25)
    }
    
    var body: some View {
        VStack {
//            Text("Placar")
//                .font(.title2)
//                .bold()
            HStack {
                ZStack(alignment: .center) {
                    firstPlayer
                        .frame(width: 50)
                    Text("\(viewModel.firstPlayerScore)")
                        .font(.callout)
                        .bold()
                }
                ZStack(alignment: .center) {
                    oldWoman
                        .frame(width: 50)
                    Text("\(viewModel.oldWomanScore)")
                        .font(.callout)
                        .bold()
                }
                ZStack(alignment: .center) {
                    secondPlayer
                        .frame(width: 50)
                    Text("\(viewModel.secondPlayerScore)")
                        .font(.callout)
                        .bold()
                }
            }
            
            Spacer()
            GameBoardView(
                gameBoard: $viewModel.gameBoard,
                boardPlaceSelectCompletion: viewModel.setSelectPosition(_:)
            )
            Spacer()
            
            HStack {
//                Text("Turno:")
                firstPlayer
                    .opacity(getCurrentOpacity(to: .first))
                secondPlayer
                    .opacity(getCurrentOpacity(to: .second))
//                Text(viewModel.currentPlayer.rawValue)
            }
            .font(.title2)
            .animation(.interpolatingSpring, value: getCurrentOpacity(to: .first))
            .animation(.interpolatingSpring, value: getCurrentOpacity(to: .second))

        }
        .padding()
        .alert(viewModel.getWinnerMessage(),
               isPresented: $viewModel.isWinner) {
            Button("Ok") { viewModel.gameBoard.resetBoard() }
        }
        .alert(viewModel.getOldWomanWinnerMessage(),
               isPresented: $viewModel.oldWomanWinner) {
            Button("Ok") { viewModel.gameBoard.resetBoard() }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    viewModel.gameBoard.resetBoard()
                }, label: {
                    Image(systemName: "arrow.triangle.2.circlepath.circle")
                })
            }
        }
    }
}

struct BoardPlace: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var gameBoard: GameBoardProtocol
    var position: PositionType
    var selectedPlaceCompletion: (_ position: PositionType) -> Void
    
    var body: some View {
        Button(role: .none,
               action: {
            selectedPlaceCompletion(position)
        },
               label: {
            //            ZStack {
            //                Rectangle()
            //                    .fill(Color.clear)
            //                Circle()
            //                    .fill(getFillColor())
            //                    .padding()
            //            }
            Rectangle()
                .fill(getFillColor())
        })
    }
    
    private func getFillColor() -> Color {
        let player = gameBoard.getPlayer(to: position)
        switch player {
        case .first:
            return .blue
        case .second:
            return .yellow
        case .undefined:
            if colorScheme == .dark {
                return .black
            } else {
                return .white
            }
//            return colorScheme == .dark ? .black : .white
        }
    }
}

#Preview {
    JogoDaVelhaView(
        viewModel: JogoDaVelhaViewModel(gameBoard: GameBoard())
    )
}
