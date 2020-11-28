//
//  GameScene.swift
//  Pong
//
//  Created by Joshua Dadson on 11/27/20.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene {
    
    let playerOne = SKSpriteNode()
    
    override func sceneDidLoad() {
        playerOne.color = .blue
        playerOne.size = CGSize(width: (self.scene?.size.width)!/3, height: (self.scene?.size.height)!/30)
        playerOne.position = CGPoint(x: (self.scene?.size.width)!/2, y: 150)
    }
    
    override func didMove(to view: SKView) {
        addChild(playerOne)
    }
        

 
}
