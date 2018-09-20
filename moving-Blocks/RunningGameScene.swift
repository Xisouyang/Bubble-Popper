//
//  GameScene.swift
//  Game-Starter-Empty
//
//  Created by mitchell hudson on 9/13/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    /* setup variables */
    let top = CGPoint(x: 0, y: 550);
    let border = 275;
    let bottom : CGFloat = 50;
    let angle : CGFloat = 30;
    var score = 1;
    var scoreArr: [SKLabelNode] = [];
    var endScene = EndGameScene();
    
    // Called when the scene has been displayed
    override func didMove(to view: SKView) {
        
        scoreLabel();
        
        /* starts the game */
        let delay = SKAction.wait(forDuration: 0.8);
        let runSequence = SKAction.run {
            self.startSequence();
        }
        let start = SKAction.sequence([delay, runSequence]);
        let goForev = SKAction.repeatForever(start);
        self.run(goForev);
    }
    
    /* creates block, start actions */
    func startSequence() {
        let random = arc4random_uniform(50);
        let node = createBlock(size: CGSize(width: CGFloat(random) + 10, height: CGFloat(random) + 10))
        randomPos(node: node);
        blockActions(node: node);
    }
    /* returns random color for blocks */
    func randomColor() -> UIColor {
        let colorArr : [UIColor] = [.blue, .cyan, .yellow, .green, .orange, .purple, .red ]
        return colorArr[Int(arc4random_uniform(7))];
    }
    
    /* creates block */
    func createBlock(size: CGSize) -> SKSpriteNode {
        let node = SKSpriteNode(texture: nil, color: randomColor(), size: size);
        node.name = "block";
        addChild(node);
        return node;
    }
    
    /* create score label */
    func scoreLabel() {
        let score = SKLabelNode(text: "1");
        let fontSize: CGFloat = 40;
        score.color = UIColor.white;
        score.position = CGPoint(x: (self.size.width / 2), y: 550);
        score.fontName = "Futura-Bold";
        score.fontSize = fontSize;
        
        addChild(score);
        scoreArr.append(score);
        
//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font names: \(names)")
//        }
    }
    
    /* randomize start position of block */
    func randomPos(node: SKSpriteNode) {
        node.position.y = CGFloat(arc4random_uniform(UInt32(top.y)))
        node.position.x = CGFloat(arc4random_uniform(UInt32(border)) + 50);
    }
    
    /* delete block */
    func deleteBlock(node: SKSpriteNode) {
        node.removeFromParent();
    }
    
    /*
       all actions of block
         - move up
         - rotate
         - delete
     */
    func blockActions(node: SKSpriteNode) {
        let randomTime = arc4random_uniform(10);
        let moveUp = SKAction.moveBy(x: 0, y: top.y - node.position.y, duration: TimeInterval(randomTime))
        let delete = SKAction.run {
            self.deleteBlock(node: node)
            self.score -= 1;
            
            /* lose condition */
            if self.score == 0 {
                // let reveal = SKTransition.reveal(with: .down,
                   //                               duration: 1);
                 //self.scene?.view?.presentScene(, transition: reveal)
                
                self.scene?.view?.presentScene(EndGameScene(size: self.size))
            }
            
            self.scoreArr[0].text = String(self.score);
        }
        let blockSequence = SKAction.sequence([moveUp, delete]);
        
        
        let rotate = SKAction.rotate(byAngle: angle, duration: 5);
        let rotateForever = SKAction.repeatForever(rotate);
        
        
        let actionGroup = SKAction.group([rotateForever, blockSequence]);
        
        node.run(actionGroup);
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if score < 0 {
            scoreArr[0].text = "Game Over";
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
