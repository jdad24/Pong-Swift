//
//  ContentView.swift
//  PongWars
//
//  Created by Joshua Dadson on 10/21/23.
//

import SwiftUI
import SpriteKit
import Foundation

struct ContentView: View {
    @State private var presentGame = false
    
    var body: some View {
        NavigationStack {
            ZStack{
                Rectangle()
                    .fill(Gradient(colors: [.blue, .black]))
                    .ignoresSafeArea()
                
                VStack {
                    Text("Pong Wars")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Button("Play") {
                        presentGame = true
                        print("Play button pressed")
                    }.frame(width: 50, height: 50)
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.black)
                        .clipShape(Circle())
                        .fullScreenCover(isPresented: $presentGame){
                            SpriteView(scene: GameScene())
                        }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

#Preview {
    ContentView()
}
