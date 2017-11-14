//
//  MenuVC.swift
//  SimpleTennis
//
//  Created by Dai Haneda on 2017/11/14.
//  Copyright © 2017年 Dai Haneda. All rights reserved.
//

import Foundation
import UIKit

enum gameType {
  case easy
  case medium
  case hard
  case player2
}

class MenuVC : UIViewController {
 
  @IBAction func player2Button(_ sender: Any) {
    moveToGame(game: .player2)
  }
  
  @IBAction func easyButton(_ sender: Any) {
    moveToGame(game: .easy)
  }

  @IBAction func mediumButton(_ sender: Any) {
    moveToGame(game: .medium)
  }

  @IBAction func hardButton(_ sender: Any) {
    moveToGame(game: .hard)
  }
  
  func moveToGame(game: gameType) {
    let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
    currentGameType = game
    self.navigationController?.isNavigationBarHidden = true
    self.navigationController?.pushViewController(gameVC, animated: true)


  }
}
