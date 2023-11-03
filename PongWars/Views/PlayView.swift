//
//  PlayView.swift
//  PongWars
//
//  Created by Joshua Dadson on 11/2/23.
//

import SwiftUI
import SpriteKit

struct PlayView: View {
    @Binding var presentGame: Bool
    
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
                        .padding(EdgeInsets(top: 20.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                    Spacer()
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
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

#Preview {
    PlayView(presentGame: .constant(false))
}
