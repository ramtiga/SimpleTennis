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
  var score = [Int]()
  var mainScoreLbl = SKLabelNode()
  var enemyScoreLbl = SKLabelNode()
    
  override func didMove(to view: SKView) {
    main = self.childNode(withName: "main") as! SKSpriteNode
    main.position.y = (-self.frame.height / 2) + 50
    
    enemy = self.childNode(withName: "enemy") as! SKSpriteNode
    enemy.position.y = (self.frame.height / 2) - 50
    
    ball = self.childNode(withName: "ball") as! SKSpriteNode
    
    mainScoreLbl = self.childNode(withName: "mainScoreLbl") as! SKLabelNode
    enemyScoreLbl = self.childNode(withName: "enemyScoreLbl") as! SKLabelNode
    
    let border = SKPhysicsBody(edgeLoopFrom: self.frame)
    
    border.friction = 0
    border.restitution = 1
    
    self.physicsBody = border
    startGame()
  }
  
  func startGame() {
    score = [0, 0]
    mainScoreLbl.text = "\(score[0])"
    enemyScoreLbl.text = "\(score[1])"
    ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
  }
  
  func addScore(player: SKSpriteNode) {
    ball.position = CGPoint(x: 0, y: 0)
    ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
    
    if player == main {
      score[0] += 1
      ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
    } else if player == enemy {
      score[1] += 1
      ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: -10))
    }
    mainScoreLbl.text = "\(score[0])"
    enemyScoreLbl.text = "\(score[1])"
  }
  
  
  override func update(_ currentTime: TimeInterval) {
    // Called before each frame is rendered
    switch currentGameType {
    case .easy:
      enemy.run(SKAction.moveTo(x: ball.position.x, duration: 2.0))
      break
    case .medium:
      enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
      break
    case .hard:
      enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.5))
      break
    case .player2:
      break
    }

    if ball.position.y <= main.position.y - 30 {
      addScore(player: enemy)
    } else if ball.position.y >= enemy.position.y + 30 {
      addScore(player: main)
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    for touch in touches {
      let location = touch.location(in: self)
      
      if currentGameType == .player2 {
        if location.y > 0 {
          enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
        } else if location.y <= 0 {
          main.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
      } else {
        main.run(SKAction.moveTo(x: location.x, duration: 0.2))
      }
    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    for touch in touches {
      let location = touch.location(in: self)
      
      if currentGameType == .player2 {
        if location.y > 0 {
          enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
        } else if location.y <= 0 {
          main.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
      } else {
        main.run(SKAction.moveTo(x: location.x, duration: 0.2))
      }
    }
  }
}
