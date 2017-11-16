//
//  StartScene.swift
//  SimpleTennis
//
//  Created by Dai Haneda on 2017/11/15.
//  Copyright © 2017年 Dai Haneda. All rights reserved.
//

import SpriteKit
import GameplayKit

class StartScene: SKScene {

  override func didMove(to view: SKView) {
    //1Player
    let player1Button = SKSpriteNode(imageNamed: "1player.png")
    player1Button.position = CGPoint(x: 0, y: (self.frame.height / 2) - (self.frame.height / 4))
    player1Button.name = "player1Button"
    self.addChild(player1Button)
    //Easy
    let easyButton = SKSpriteNode(imageNamed: "easy.png")
    easyButton.position = CGPoint(x: 0, y: player1Button.position.y - self.frame.height / 10)
    easyButton.name = "easyButton"
    self.addChild(easyButton)
    //Medium
    let mediumButton = SKSpriteNode(imageNamed: "medium.png")
    mediumButton.position = CGPoint(x: 0, y: easyButton.position.y - self.frame.height / 10)
    mediumButton.name = "mediumButton"
    self.addChild(mediumButton)
    //Hard
    let hardButton = SKSpriteNode(imageNamed: "hard.png")
    hardButton.position = CGPoint(x: 0, y: mediumButton.position.y - self.frame.height / 10)
    hardButton.name = "hardButton"
    self.addChild(hardButton)
    //2Player
    let player2Button = SKSpriteNode(imageNamed: "2player.png")
    player2Button.position = CGPoint(x: 0, y: hardButton.position.y - self.frame.height / 10)
    player2Button.name = "player2Button"
    self.addChild(player2Button)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    for touche in touches {
      let location = touche.location(in: self)
      if self.atPoint(location).name == "easyButton" {
        currentGameType = .easy
        toGameScene()
      } else if self.atPoint(location).name == "mediumButton" {
        currentGameType = .medium
        toGameScene()
      } else if self.atPoint(location).name == "hardButton" {
        currentGameType = .hard
        toGameScene()
      } else if self.atPoint(location).name == "player2Button" {
        currentGameType = .player2
        toGameScene()
      }
    }
  }
  
  func toGameScene() {
    if let view = self.view as SKView? {
      if let scene = SKScene(fileNamed: "GameScene") {
        scene.scaleMode = .aspectFill
        scene.size = view.bounds.size
        view.presentScene(scene)
      }
    }
  }
}
