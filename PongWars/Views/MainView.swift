//
//  MainView.swift
//  PongWars
//
//  Created by Joshua Dadson on 11/2/23.
//

import SwiftUI
import SpriteKit

struct MainView: View {
    @Binding var presentPracticeMode: Bool
    @Binding var presentMultiplayer: Bool
    
    init(presentPracticeMode: Binding<Bool>, presentMultiplayer: Binding<Bool>) {
        self._presentPracticeMode = presentPracticeMode
        self._presentMultiplayer = presentMultiplayer
        
        GCManager.authenticatePlayer()
    }
    
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
                    Button("Practice") {
                        presentPracticeMode = true
                        print("Practice button pressed")
                    }.frame(width: 150, height: 150)
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.black)
                        .clipShape(Circle())
                        .fullScreenCover(isPresented: $presentPracticeMode){
                            SpriteView(scene: PracticeScene())
                        }
                    Spacer()
                    Button("Online Multiplayer") {
                        presentMultiplayer = true
                    }.frame(width: 150, height: 150)
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.black)
                        .clipShape(Circle())
                        .fullScreenCover(isPresented: $presentMultiplayer){
                            SpriteView(scene: PracticeScene())
                        }
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

#Preview {
    MainView(presentPracticeMode: .constant(false), presentMultiplayer: .constant(false))
}
