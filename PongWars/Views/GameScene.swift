//
//  GameScene.swift
//  PongWars
//
//  Created by Joshua Dadson on 10/23/23.
//

import SpriteKit

enum NodeCategory: UInt32 {
    case player = 1
    case enemy = 2
    case ball = 4
    case border = 8
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    var player: PaddleNode!
    var enemy: PaddleNode!
    var ball: BallNode!
    
    var playerStartPosition: CGPoint!
    var enemyStartPosition: CGPoint!
    var ballStartPosition: CGPoint!
    
    override func didMove(to view: SKView) {
        self.size = CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: view.safeAreaLayoutGuide.layoutFrame.height)
        
        playerStartPosition = CGPoint(x: self.size.width/2, y: 15)
        enemyStartPosition = CGPoint(x: self.size.width/2, y: self.size.height - 15)
        ballStartPosition = CGPoint(x: self.size.width/2, y: self.size.height/2)
        
        player = PaddleNode(color: .blue, size: CGSize(width: (self.size.width)/3, height: self.size.height/30))
        player.name = "Player"
        player.position = playerStartPosition
        
        enemy = PaddleNode(color: .red, size:  CGSize(width: self.size.width/3, height: self.size.height/30))
        enemy.name = "Enemy"
        enemy.position = enemyStartPosition
        
        ball = BallNode(circleOfRadius: 25)
        ball.name = "Ball"
        ball.position = ballStartPosition
        
        isPaused = false
        
        addChild(player)
        addChild(enemy)
        addChild(ball)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: -50, width: frame.width, height: frame.height + 100))
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
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50))
        
        //Check if weak self is necessary
        Timer.scheduledTimer(withTimeInterval: 0.10, repeats: true) { [self]_ in
            var xPos = ball.position.x
            
            if xPos >= self.size.width - enemy.size.width/2 {
                xPos = self.size.width - enemy.size.width/2
            } else if xPos <= enemy.size.width  {
                xPos = enemy.size.width/2
            }
            let enemyMoveAction = SKAction.move(to: CGPoint(x: xPos, y: enemy.position.y), duration: 0.15)
            enemy.run(enemyMoveAction, withKey: "enemyMoveAction")
//            print("time :)")
        }
        
    }

    
    
    func restart() {
        isPaused = true
        
        player.position = playerStartPosition
        enemy.position = enemyStartPosition
        ball.position = ballStartPosition
        
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50))
    }
    
    override func sceneDidLoad() {
        scene?.backgroundColor = .black
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isPaused {
            isPaused = false
            return
        }
        
        var movePlayerAction = SKAction()
        var xVal: CGFloat = 0
        
        if let touch = touches.first {
            if (touch.location(in: self).x > self.size.width/2) && (player.position.x < player.size.width/2 + self.size.width) && !player.touchingRight{
                xVal = 1000
                movePlayerAction = SKAction.moveBy(x: xVal, y: 0, duration: 1.25)
                player.touchingLeft = false
                
            } else if (touch.location(in: self).x < self.size.width/2) && (player.position.x > 0 - player.size.width/2 ) && !player.touchingLeft {
                xVal = -1000
                movePlayerAction = SKAction.moveBy(x: xVal, y: 0, duration: 1.25)
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
            
            let dxVal = Int.random(in: -50...50)
            let dyVal = 70
            
            if nodeA == player && nodeB == ball {
                nodeB?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                nodeB?.physicsBody?.applyImpulse(CGVector(dx: dxVal, dy: dyVal))
            } else if nodeA == ball && nodeB == player {
                nodeA?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                nodeA?.physicsBody?.applyImpulse(CGVector(dx: dxVal, dy: dyVal))
            }
            
            if nodeA == enemy && nodeB == ball {
                nodeB?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                nodeB?.physicsBody?.applyImpulse(CGVector(dx: dxVal, dy: -dyVal))
            } else if nodeA == ball && nodeB == enemy {
                nodeA?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                nodeA?.physicsBody?.applyImpulse(CGVector(dx: dxVal, dy: -dyVal))
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
            if ball.position.y < player.position.y - 10 || ball.position.y > enemy.position.y + 10{
                restart()
            }

        }
    
    }
