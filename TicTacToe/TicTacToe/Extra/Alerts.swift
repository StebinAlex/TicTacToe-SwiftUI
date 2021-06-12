//
//  Alerts.swift
//  TicTacToe
//
//  Created by LTS on 06/06/21.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    static let humanWin     = AlertItem(title: Text("You win!"), message: Text("You are too smart. your beat your own AI"), buttonTitle: Text("Well Yeah!"))
    static let computerWin  = AlertItem(title: Text("You Lost"), message: Text("You programmed a super AI"), buttonTitle: Text("Rematch"))
    static let draw         = AlertItem(title: Text("Draw"), message: Text("What a battle we have witnessed here."), buttonTitle: Text("Try again."))
}
