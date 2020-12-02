//
//  Ball.swift
//  Pong
//
//  Created by Joshua Dadson on 12/1/20.
//

import UIKit

import UIKit
import SpriteKit

class Ball: SKShapeNode {
  
    override init() {
        super.init()
        physicsBody = SKPhysicsBody(circleOfRadius: 25)
        physicsBody?.isDynamic = true
        fillColor = .orange
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
