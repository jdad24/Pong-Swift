//
//  Paddle.swift
//  Pong
//
//  Created by Joshua Dadson on 12/1/20.
//

import UIKit
import SpriteKit

class Paddle: SKSpriteNode {
    var touchingRight = false
    var touchingLeft = false
    
    init(color: UIColor, size: CGSize) {
        super.init(texture: nil, color: color, size: size)
        
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width, height: size.height))
        physicsBody?.isDynamic = true
        physicsBody?.affectedByGravity = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
