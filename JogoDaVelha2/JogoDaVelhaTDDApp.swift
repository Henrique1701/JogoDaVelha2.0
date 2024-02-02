//
//  JogoDaVelha2App.swift
//  JogoDaVelha2
//
//  Created by José Henrique Fernandes Silva on 29/01/24.
//

import SwiftUI

@main
struct JogoDaVelha2App: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                JogoDaVelhaView(
                    viewModel: .init(gameBoard: GameBoard())
                )
            }
        }
    }
}
