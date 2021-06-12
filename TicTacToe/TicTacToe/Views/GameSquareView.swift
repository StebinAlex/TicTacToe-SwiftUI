//
//  GameSquareView.swift
//  TicTacToe
//
//  Created by LTS on 06/06/21.
//

import SwiftUI

struct GameSquareView: View {
    
    
    var proxy: GeometryProxy
     
    var body: some View {
         
        Circle()
            .frame(width: proxy.size.width/3 - 15, height: proxy.size.width/3 - 15)
            .foregroundColor(.red)
    }
    
}
