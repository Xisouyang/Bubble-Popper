//
//  EndGameScene.swift
//  moving-Blocks
//
//  Created by Stephen Ouyang on 9/20/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import SpriteKit
import GameplayKit


class EndGameScene: SKScene {
    
    let label = SKLabelNode(text: "Game Over");
    
    override func didMove(to view: SKView) {
        
        let fontSize: CGFloat = 40;
        label.color = UIColor.white;
        label.position = CGPoint(x: (self.size.width / 2), y: 550);
        label.fontName = "Futura-Bold";
        label.fontSize = fontSize;
        addChild(label);
    }
}
