//
//  GameScene.swift
//  SimpleTennis
//
//  Created by Dai Haneda on 2017/11/13.
//  Copyright © 2017年 Dai Haneda. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
  
  var main = SKSpriteNode()
  var enemy = SKSpriteNode()
  var ball = SKSpriteNode()
  var score = [Int]()
  var mainScoreLbl = SKLabelNode()
  var enemyScoreLbl = SKLabelNode()

  var gameoverFlg: Bool = false
  let sound1 = SKAction.playSoundFileNamed("button01b.mp3", waitForCompletion: true)
  
  let POINT_LIMIT = 2

  override func didMove(to view: SKView) {
    main = self.childNode(withName: "main") as! SKSpriteNode
    main.position.y = (-self.frame.height / 2) + 50
    
    enemy = self.childNode(withName: "enemy") as! SKSpriteNode
    enemy.position.y = (self.frame.height / 2) - 50
    
    ball = self.childNode(withName: "ball") as! SKSpriteNode
    
    mainScoreLbl = self.childNode(withName: "mainScoreLbl") as! SKLabelNode
    enemyScoreLbl = self.childNode(withName: "enemyScoreLbl") as! SKLabelNode
    
    mainScoreLbl.position.x = (-self.frame.width / 2) + 50
    enemyScoreLbl.position.x = (-self.frame.width / 2) + 50

    let border = SKPhysicsBody(edgeLoopFrom: self.frame)
    
    border.friction = 0
    border.restitution = 1
    
    self.physicsBody = border
    self.physicsWorld.contactDelegate = self
    startGame()
  }
  
  //ゲーム開始処理
  func startGame() {
    score = [0, 0]
    mainScoreLbl.text = "\(score[0])"
    enemyScoreLbl.text = "\(score[1])"
    ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
  }
  
  //スコア更新
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
    
    //7点先取で終了
    if score[1] > POINT_LIMIT || score[0] > POINT_LIMIT {
      self.isPaused = true
      self.gameoverFlg = true
      
      if score[0] > POINT_LIMIT {
        //enemy loser
        let enemyResultLbl = SKLabelNode(fontNamed: "LLPIXEL")
        enemyResultLbl.position = CGPoint(x: 0, y: 130)
        enemyResultLbl.zRotation = CGFloat(GLKMathDegreesToRadians(180))
        enemyResultLbl.text = "LOSER"
        enemyResultLbl.fontSize = 28
        enemyResultLbl.fontColor = UIColor.green
        self.addChild(enemyResultLbl)
        
        //main win
        let mainResultLbl = SKLabelNode(fontNamed: "LLPIXEL")
        mainResultLbl.position = CGPoint(x: 0, y: -130)
        mainResultLbl.text = "WINNER!"
        mainResultLbl.fontSize = 28
        mainResultLbl.fontColor = UIColor.green
        self.addChild(mainResultLbl)
      }
      else if score[1] > POINT_LIMIT {
        //enemy win
        let enemyResultLbl = SKLabelNode(fontNamed: "LLPIXEL")
        enemyResultLbl.position = CGPoint(x: 0, y: 130)
        enemyResultLbl.zRotation = CGFloat(GLKMathDegreesToRadians(180))
        enemyResultLbl.text = "WINNER!"
        enemyResultLbl.fontSize = 28
        enemyResultLbl.fontColor = UIColor.green
        self.addChild(enemyResultLbl)
        
        //main loser
        let mainResultLbl = SKLabelNode(fontNamed: "LLPIXEL")
        mainResultLbl.position = CGPoint(x: 0, y: -130)
        mainResultLbl.text = "LOSER"
        mainResultLbl.fontSize = 28
        mainResultLbl.fontColor = UIColor.green
        self.addChild(mainResultLbl)
      }
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //ゲームオーバー時はメニューに戻る
    if gameoverFlg {
      if let scene = SKScene(fileNamed: "StartScene") {
        if let view = self.view as SKView? {
          scene.scaleMode = .aspectFill
          scene.size = view.bounds.size
          view.presentScene(scene)
        }
      }
      
      return
    }
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

  //衝突処理
  func didBegin(_ contact: SKPhysicsContact) {
    //ラケットに当たった場合のみ効果音
    if contact.bodyA.categoryBitMask == 1 || contact.bodyB.categoryBitMask == 1 {
      self.run(sound1)
    }
  }
  
}
