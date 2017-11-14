//
//  GameScene.swift
//  SimpleTennis
//
//  Created by Dai Haneda on 2017/11/13.
//  Copyright © 2017年 Dai Haneda. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
  
  var main = SKSpriteNode()
  var enemy = SKSpriteNode()
  var ball = SKSpriteNode()
    
    private var label : SKLabelNode?
  private var spinnyNode : SKShapeNode?
  
  override func didMove(to view: SKView) {
    main = self.childNode(withName: "main") as! SKSpriteNode
    enemy = self.childNode(withName: "enemy") as! SKSpriteNode
    ball = self.childNode(withName: "ball") as! SKSpriteNode
    
    ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
    
    let border = SKPhysicsBody(edgeLoopFrom: self.frame)
    
    border.friction = 0
    border.restitution = 1
    
    self.physicsBody = border
  }
  
  override func update(_ currentTime: TimeInterval) {
    // Called before each frame is rendered
    enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    for touch in touches {
      let location = touch.location(in: self)
      main.run(SKAction.moveTo(x: location.x, duration: 0.2))
    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    for touch in touches {
      let location = touch.location(in: self)
      main.run(SKAction.moveTo(x: location.x, duration: 0.2))
    }
  }
}
