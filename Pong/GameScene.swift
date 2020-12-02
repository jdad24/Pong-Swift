//
//  GameScene.swift
//  Pong
//
//  Created by Joshua Dadson on 11/27/20.
//

import SpriteKit
import GameplayKit

enum NodeCategory: UInt32 {
    case player = 1
    case enemy = 2
    case ball = 4
    case border = 8
}


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player : Paddle!
    var enemy : Paddle!
    var ball : Ball!
    
    func restart() {
        isPaused = true
        
        player.position = CGPoint(x: (self.scene?.size.width)!/2, y: 150)
        enemy.position = CGPoint(x: (self.scene?.size.width)!/2, y: (self.scene?.size.height)! - 150)
        ball.position = CGPoint(x: (self.scene?.size.width)!/2, y: (self.scene?.size.height)!/2)
    }
    
    override func sceneDidLoad() {
        player = Paddle(color: .blue, size: CGSize(width: (self.scene?.size.width)!/3, height: (self.scene?.size.height)!/30))
        player.name = "Player"
        player.position = CGPoint(x: (self.scene?.size.width)!/2, y: 150)
        
        enemy = Paddle(color: .red, size:  CGSize(width: (self.scene?.size.width)!/3, height: (self.scene?.size.height)!/30))
        enemy.name = "Enemy"
        enemy.position = CGPoint(x: (self.scene?.size.width)!/2, y: (self.scene?.size.height)! - 150)
        
        ball = Ball(circleOfRadius: 25)
        ball.name = "Ball"
        ball.position = CGPoint(x: (self.scene?.size.width)!/2, y: (self.scene?.size.height)!/2)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isPaused {
            isPaused = false
            return
        }
        
        var movePlayerAction = SKAction()
        var dxVal: CGFloat = 0
        
        if let touch = touches.first {
            if (touch.location(in: self).x > (self.scene?.size.width)!/2) && (player.position.x < player.size.width/2 + (self.scene?.size.width)!) && !player.touchingRight{
                dxVal = 1000
                movePlayerAction = SKAction.moveBy(x: dxVal, y: 0, duration: 1.25)
                player.touchingLeft = false
                
            } else if (touch.location(in: self).x < (self.scene?.size.width)!/2) && (player.position.x > 0 - player.size.width/2 ) && !player.touchingLeft {
                dxVal = -1000
                movePlayerAction = SKAction.moveBy(x: dxVal, y: 0, duration: 1.25)
                player.touchingRight = false
            }
            
            //            player.physicsBody?.applyImpulse(CGVector(dx: dxVal, dy: 0))
            player.run(movePlayerAction, withKey: "movePlayerAction")
            
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        player.removeAction(forKey: "movePlayerAction")
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        
//        print(nodeA!)
//        print(nodeB!)
        
        let dxVal = Int.random(in: -70...70)
        let dyVal = 150
        
        if nodeA == player && nodeB == ball {
            nodeB?.physicsBody?.applyImpulse(CGVector(dx: dxVal, dy: dyVal))
        } else if nodeA == ball && nodeB == player {
            nodeA?.physicsBody?.applyImpulse(CGVector(dx: dxVal, dy: dyVal))
        }
        
        if nodeA == enemy && nodeB == ball {
            nodeB?.physicsBody?.applyImpulse(CGVector(dx: dxVal, dy: dyVal))
        } else if nodeA == ball && nodeB == enemy {
            nodeA?.physicsBody?.applyImpulse(CGVector(dx: dxVal, dy: dyVal))
        }
        
        if nodeA == player && nodeB?.name == self.name {
            if player.position.x > (self.scene?.size.width)!/2 {
                player.touchingRight = true
            } else if player.position.x < (self.scene?.size.width)!/2 {
                player.touchingLeft = true
            }
            
            player.removeAction(forKey: "movePlayerAction")
            
        } else if nodeA?.name == self.name && nodeB == player {
            if player.position.x > (self.scene?.size.width)!/2 {
                player.touchingRight = true
            } else if player.position.x < (self.scene?.size.width)!/2 {
                player.touchingLeft = true
            }
            
            player.removeAction(forKey: "movePlayerAction")
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if ball.position.y < player.position.y - 100 || ball.position.y > enemy.position.y + 100{
            restart()
        }

    }
    
    
    
    override func didMove(to view: SKView) {
        isPaused = true
        
        addChild(player)
        addChild(enemy)
        addChild(ball)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        physicsBody?.categoryBitMask = NodeCategory.border.rawValue
        physicsWorld.contactDelegate = self
        physicsBody?.contactTestBitMask = NodeCategory.player.rawValue
        self.name = "scene"
        
        player.physicsBody?.categoryBitMask = NodeCategory.player.rawValue
        player.physicsBody?.collisionBitMask = NodeCategory.border.rawValue
        player.physicsBody?.contactTestBitMask = NodeCategory.ball.rawValue
        
        ball.physicsBody?.categoryBitMask = NodeCategory.ball.rawValue
        ball.physicsBody?.collisionBitMask = NodeCategory.player.rawValue | NodeCategory.border.rawValue | NodeCategory.enemy.rawValue
        ball.physicsBody?.contactTestBitMask = NodeCategory.player.rawValue | NodeCategory.enemy.rawValue
        
        enemy.physicsBody?.categoryBitMask = NodeCategory.enemy.rawValue
        enemy.physicsBody?.collisionBitMask = NodeCategory.border.rawValue
        
        
        //Check if weak self is necessary
        Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { [self]_ in
            var xPos = ball.position.x
            
            if ball.position.x >= (self.scene?.size.width)! - enemy.size.width/2 {
                xPos = self.scene!.size.width - enemy.size.width/2
            } else if ball.position.x <= enemy.size.width  {
                xPos = enemy.size.width/2
            }
            let enemyMoveAction = SKAction.move(to: CGPoint(x: xPos, y: enemy.position.y), duration: 0.15)
            enemy.run(enemyMoveAction, withKey: "enemyMoveAction")
//            print("time :)")
        }
        
    }
    
    
    
    
}
