//
//  GameScene.swift
//  Game-Starter-Empty
//
//  Created by mitchell hudson on 9/13/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import SpriteKit
import GameplayKit

var score = 1;
var scoreArr: [SKLabelNode] = [];

class RunningGameScene: SKScene {
    
    // Called when the scene has been displayed
    override func didMove(to view: SKView) {
        
        scoreLabel()
        
        /* starts the game */
        let delay = SKAction.wait(forDuration: 1);
        let runSequence = SKAction.run {
            self.startSequence();
        }
        let start = SKAction.sequence([delay, runSequence]);
        let goForev = SKAction.repeatForever(start);
        self.run(goForev);
    }
    
    /* creates block, start actions */
    func startSequence() {
        let node = Box(view: self.view!);
        addChild(node);
        node.blockActions(node: node);
    }
    
    /* create score label */
    func scoreLabel() {
        let score = Labels(text: "1", color: .white, fontSize: 40, font: "Futura-Bold", position: CGPoint(x: (self.size.width / 2), y: 550));
        scoreArr.append(score);
        addChild(score);

//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font names: \(names)")
//        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if score == 0 || score < 0 {
            self.scene?.view?.presentScene(EndGameScene(size: self.size))
        }
    }
    
    /* when block touched, delete block and increase score */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self);
            let node = atPoint(location);
            if node.name == "block" {
                node.removeFromParent();
                score += 1;
                scoreArr[0].text = String(score);
            }
        }
    }
}
