//
//  PlayerModel.swift
//  TicTacToe
//
//  Created by Othmar Gispert on 10/8/22.
//

import Foundation

enum Player {
    case human
    case computer
}

struct Move {
    let player: Player
    let boardIndex: Int

    var indicator: String {
        player == .human ? "xmark" : "circle"
    }
}
