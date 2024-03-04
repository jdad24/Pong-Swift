//
//  Ball.swift
//  Pong
//
//  Created by Joshua Dadson on 12/1/20.
//

import UIKit

import UIKit
import SpriteKit

class BallNode: SKShapeNode {
    
    var radius: CGFloat!
    
    init(circleOfRadius: CGFloat) {
        super.init()
        
        radius = circleOfRadius
        
        let circlePath = CGMutablePath()
        circlePath.addArc(center: CGPoint.zero,
                    radius: radius,
                    startAngle: 0,
                    endAngle: CGFloat.pi * 2,
                    clockwise: true)
        
        self.path = circlePath
            
        
        physicsBody = SKPhysicsBody(polygonFrom: circlePath)
        physicsBody?.isDynamic = true
        physicsBody?.affectedByGravity = false
        
        strokeColor = .white
        fillColor = .blue
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
