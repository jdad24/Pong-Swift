//
//  SettingsView.swift
//  PongWars
//
//  Created by Joshua Dadson on 11/2/23.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Gradient(colors: [.blue, .black]))
                .ignoresSafeArea()
            VStack {
                Text("Settings")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top:20.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                Spacer()
            }
        }
    }
}

#Preview {
    SettingsView()
}
