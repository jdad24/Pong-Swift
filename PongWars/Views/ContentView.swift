//
//  ContentView.swift
//  PongWars
//
//  Created by Joshua Dadson on 10/21/23.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @State private var presentGame = false
    
    var body: some View {
        TabView {
            PlayView(presentGame: $presentGame)
                .tabItem { Label("Play", systemImage: "gamecontroller.fill") }
            SettingsView()
                .tabItem { Label("Settings", systemImage: "gear.circle.fill") }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
