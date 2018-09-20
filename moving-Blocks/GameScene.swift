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
    
    let top = CGPoint(x: 0, y: 550);
    let border = 275;
    let bottom : CGFloat = 50;
    let angle : CGFloat = 30;
    var score = 0;
    var scoreArr: [SKLabelNode] = [];
  
    override func didMove(to view: SKView) {
        // Called when the scene has been displayed
        scoreLabel();
        let delay = SKAction.wait(forDuration: 0.8);
        let runSequence = SKAction.run {
            self.startSequence();
        }
        let start = SKAction.sequence([delay, runSequence]);
        let goForev = SKAction.repeatForever(start);
        self.run(goForev);
    }
    
    func startSequence() {
        let random = arc4random_uniform(50);
        let node = createBlock(size: CGSize(width: CGFloat(random) + 10, height: CGFloat(random) + 10))
        randomPos(node: node);
        blockActions(node: node);
    }
    
    func randomColor() -> UIColor {
        let colorArr : [UIColor] = [.blue, .cyan, .yellow, .green, .orange, .purple, .red ]
        return colorArr[Int(arc4random_uniform(7))];
    }
    
    func createBlock(size: CGSize) -> SKSpriteNode {
        let node = SKSpriteNode(texture: nil, color: randomColor(), size: size);
        node.name = "block";
        addChild(node);
        return node;
    }
    
    func scoreLabel() {
        let score = SKLabelNode(text: "0");
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
    
    func randomPos(node: SKSpriteNode) {
        node.position.y = CGFloat(arc4random_uniform(UInt32(top.y)))
        node.position.x = CGFloat(arc4random_uniform(UInt32(border)) + 50);
    }
    
    func deleteBlock(node: SKSpriteNode) {
        node.removeFromParent();
    }
    
    func blockActions(node: SKSpriteNode) {
        let randomTime = arc4random_uniform(10);
        let moveUp = SKAction.moveBy(x: 0, y: top.y - node.position.y, duration: TimeInterval(randomTime))
        let delete = SKAction.run {
            self.deleteBlock(node: node)
        }
        let blockSequence = SKAction.sequence([moveUp, delete]);
        
        
        let rotate = SKAction.rotate(byAngle: angle, duration: 5);
        let rotateForever = SKAction.repeatForever(rotate);
        
        
        let actionGroup = SKAction.group([rotateForever, blockSequence]);
        
        node.run(actionGroup);
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
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
