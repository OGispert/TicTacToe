//
//  GameView.swift
//  TicTacToe
//
//  Created by Othmar Gispert on 10/6/22.
//

import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Tic Tac Toe")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .padding(.top)

                Spacer()

                LazyVGrid(columns: viewModel.columns, spacing: 5) {
                    ForEach(0..<9) { index in
                        ZStack {
                            SquaresView(proxy: geometry)
                            ImagesView(systemName: viewModel.moves[index]?.indicator ?? "")
                        }
                        .onTapGesture {
                            viewModel.processPlayerMove(for: index)
                        }
                    }
                }
                .padding(.top, -100)

                Spacer()

                HStack {
                    VStack {
                        Text("You Win:")
                        Text("\(viewModel.humanWins)")
                    }

                    Spacer()

                    VStack {
                        Text("Computer Wins:")
                        Text("\(viewModel.computerWins)")
                    }
                }
                .padding()
            }
            .disabled(viewModel.isBoardDisabled)
            .padding()
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: .default(alertItem.buttonTitle, action: {
                    viewModel.resetBoard()
                }))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
