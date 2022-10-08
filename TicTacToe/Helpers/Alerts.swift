//
//  Alerts.swift
//  TicTacToe
//
//  Created by Othmar Gispert on 10/6/22.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    static let humanWin = AlertItem(title: Text("You win!!"),
                                    message: Text("You are awesome."),
                                    buttonTitle: Text("Hell yeah"))

    static let computerWin = AlertItem(title: Text("You lost!!"),
                                       message: Text("You are not that awesome."),
                                       buttonTitle: Text("Oh no"))

    static let draw = AlertItem(title: Text("Draw!!"),
                                message: Text("We both are awesome."),
                                buttonTitle: Text("mehhh"))
}
