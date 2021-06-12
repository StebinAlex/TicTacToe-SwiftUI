//
//  GameModel.swift
//  TicTacToe
//
//  Created by LTS on 06/06/21.
//

import Foundation

enum Player {
    case human,computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    var indicator: String {
        player == .human ? "xmark" : "circle"
    }
}
