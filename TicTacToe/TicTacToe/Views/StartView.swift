//
//  StartView.swift
//  TicTacToe
//
//  Created by LTS on 06/06/21.
//

import SwiftUI

struct StartView: View {
     
    @State private var isShowingGameView = false
    @State private var animate: Bool = false
    
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack {
                    NavigationLink(
                        destination: GameView(),
                        isActive: $isShowingGameView,
                        label: { })
                    
                    SView(proxy: proxy)
                    Spacer()
                    Button("START") {
                        startPressed()
                    }
                    .foregroundColor(.white)
                    .font(.title)
                    .frame(width: 200, height: 50)
                    .background(Color.red)
                    .opacity( animate ? 0 : 1 )
                    .clipShape(Capsule())
                    .animation(.easeInOut(duration: 1.0))
                    Spacer()
                }
                .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
            }
        }
    }
    
    fileprivate func startPressed() {
        self.animate = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isShowingGameView = true
        }
    }
}


struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

struct SView: View {
     
    var proxy: GeometryProxy
    
    var body: some View {
        Text("Tic Tac Toe")
            .foregroundColor(.red)
            .font(.largeTitle.bold()) 
    }
}

 
