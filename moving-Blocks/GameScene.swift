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
  
  
    override func didMove(to view: SKView) {
        // Called when the scene has been displayed
        let delay = SKAction.wait(forDuration: 2);
        let runSequence = SKAction.run {
            self.startSequence();
        }
        let start = SKAction.sequence([delay, runSequence]);
        let goForev = SKAction.repeatForever(start);
        self.run(goForev);
    }
    
    func startSequence() {
        let node = createBlock(size: CGSize(width: CGFloat(arc4random_uniform(50)) + 10, height: CGFloat(arc4random_uniform(50)) + 10))
        randomPos(node: node);
        blockActions(node: node);
    }
    
    func createBlock(size: CGSize) -> SKSpriteNode {
        let node = SKSpriteNode(texture: nil, color: .cyan, size: size);
        addChild(node);
        return node;
    }
    
    func randomPos(node: SKSpriteNode) {
        node.position.y = CGFloat(arc4random_uniform(UInt32(top.y)))
        node.position.x = CGFloat(arc4random_uniform(UInt32(border)) + 50);
    }
    
    func blockActions(node: SKSpriteNode) {
        let randomTime = arc4random_uniform(10);
        let moveUp = SKAction.moveBy(x: 0, y: top.y - node.position.y, duration: TimeInterval(randomTime))
        let delete = SKAction.run {
            node.removeFromParent();
        }
        let blockSequence = SKAction.sequence([moveUp, delete]);
        node.run(blockSequence);
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
