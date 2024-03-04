//
//  GameCenter.swift
//  PongWars
//
//  Created by Joshua  Dadson on 1/25/24.
//

import Foundation
import GameKit

struct GCManager {
    
    static func authenticatePlayer() {
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            print("Player authetication started")
            print(GKLocalPlayer.local.isAuthenticated)
            
            if let _ = viewController {
                // Present view controller so player can sign in
                return
            }
            
            if error != nil {
                // Player not authenticated
                // Game Center disabled
            }
            
            // Player successfully authenticated
            // Check for restrictions
            if GKLocalPlayer.local.isUnderage {
                    // Hide explicit game content.
            }
            
            if GKLocalPlayer.local.isMultiplayerGamingRestricted {
                  // Disable multiplayer game features.
            }


            if GKLocalPlayer.local.isPersonalizedCommunicationRestricted {
                  // Disable in game communication UI.
            }
        }
    }
}
