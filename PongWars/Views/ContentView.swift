//
//  ContentView.swift
//  PongWars
//
//  Created by Joshua Dadson on 10/21/23.
//

import SwiftUI
import Foundation
import GameKit

struct ContentView: View {
    @State private var presentPracticeMode = false
    @State private var presentMultiplayer = false
    
    var body: some View {
        TabView {
            MainView(presentPracticeMode: $presentPracticeMode, presentMultiplayer: $presentMultiplayer)
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
