//
//  PlayerIndicator.swift
//  TicTacToe
//
//  Created by LTS on 06/06/21.
//

import SwiftUI

struct PlayerIndicator: View {
    
    var systemImageName: String
    
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
    }
}
