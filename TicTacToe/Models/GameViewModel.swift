//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Othmar Gispert on 10/7/22.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isBoardDisabled = false
    @Published var alertItem: AlertItem?
    @Published var humanWins = 0
    @Published var computerWins = 0

    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    private let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
                                              [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    private let centerSquare = 4

    func processPlayerMove(for position: Int) {
        // Human moves logic
        if isSquareOccupied(in: moves, for: position) {
            return
        }
        moves[position] = Move(player: .human, boardIndex: position)

        if checkWinCondition(for: .human, in: moves) {
            alertItem = AlertContext.humanWin
            humanWins += 1
            return
        }

        if checkForDraw(in: moves) {
            alertItem = AlertContext.draw
            return
        }

        isBoardDisabled = true

        // Computer moves logic
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            let computerPosition = determineComputerMovePosition(in: moves)
            moves[computerPosition] = Move(player: .computer,
                                           boardIndex: computerPosition)
            isBoardDisabled = false

            if checkWinCondition(for: .computer, in: moves) {
                alertItem = AlertContext.computerWin
                computerWins += 1
                return
            }

            if checkForDraw(in: moves) {
                alertItem = AlertContext.draw
                return
            }
        }
    }

    func resetBoard() {
        moves = Array(repeating: nil, count: 9)
    }

    // MARK: - Private methods

    private func isSquareOccupied(in moves: [Move?], for index: Int) -> Bool {
        moves.contains(where: { $0?.boardIndex == index })
    }

    private func determineComputerMovePosition(in moves: [Move?]) -> Int {
        // If AI can win, then win
        if let computerWinMove = checkForWinOrBlock(.computer) {
            return computerWinMove

        // If AI can't win, then block
        } else if let blockHumanMove = checkForWinOrBlock(.human) {
            return blockHumanMove
        }

        // If AI can't block, then take middle square
        if !isSquareOccupied(in: moves, for: centerSquare) {
            return centerSquare
        }

        // If AI can't take middle square, take random available square
        var movePosition = Int.random(in: 0..<9)

        while isSquareOccupied(in: moves, for: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }

        return movePosition
    }

    private func checkForWinOrBlock(_ player: Player) -> Int? {
        let playerPositions = getPlayerPosition(player)

        for pattern in winPatterns {
            let winPositions = pattern.subtracting(playerPositions)

            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, for: winPositions.first!)
                if isAvailable {
                    return winPositions.first!
                }
            }
        }
        return nil
    }

    private func checkWinCondition(for player: Player, in move: [Move?]) -> Bool {
        let playerPositions = getPlayerPosition(player)

        for pattern in winPatterns where pattern.isSubset(of: playerPositions) {
            return true
        }
        return false
    }

    private func getPlayerPosition(_ player: Player) -> Set<Int> {
        let moves = moves.compactMap { $0 }.filter { $0.player == player }
        return Set(moves.map { $0.boardIndex })
    }

    private func checkForDraw(in moves: [Move?]) -> Bool {
        moves.compactMap { $0 }.count == 9
    }
}
