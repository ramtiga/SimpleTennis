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
    let easyButton = SKSpriteNode(imageNamed: "easy.png")

    easyButton.position = CGPoint(x: 0, y: 0)
    easyButton.name = "easyButton"
    self.addChild(easyButton)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    for touche in touches {
      let location = touche.location(in: self)
      if self.atPoint(location).name == "easyButton" {
        currentGameType = .easy
        if let view = self.view as SKView? {
          if let scene = SKScene(fileNamed: "GameScene") {
            scene.scaleMode = .aspectFill
            scene.size = view.bounds.size

            view.presentScene(scene)
          }
        }
      }
    }
  }
}
