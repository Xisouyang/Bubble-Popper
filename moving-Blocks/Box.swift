//
//  box.swift
//  moving-Blocks
//
//  Created by Stephen Ouyang on 9/25/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import UIKit
import SpriteKit

class Box: SKSpriteNode {
    
    /* setup variables */
    let top = CGPoint(x: 0, y: 550);
    let angle : CGFloat = 30;
    let random = arc4random_uniform(30);
    var buffer = 100;
    let gameInstance = RunningGameScene();
    
    
    func randomColor() -> UIColor {
        let colorArr : [UIColor] = [.red, .blue]
        return colorArr[Int(arc4random_uniform(2))];
    }
    
    init(view: SKView) {
        super.init(texture: nil, color: .red, size: CGSize(width: CGFloat(random) + 20, height: CGFloat(random) + 20))
        
        let mineTexture = SKTexture(imageNamed: "water_mine_glare")
        let bubbleTexure = SKTexture(imageNamed: "blue-bubble-asset")
        
        color = randomColor();
        
        if color == .red {
            texture = mineTexture
            name = "bomb"
        } else {
            texture = bubbleTexure
            name = "bubble"
        }
        
       let position = CGPoint(x: CGFloat(arc4random_uniform(320) + 20), y: CGFloat(arc4random_uniform(350) + 50))
        self.position = position
    }
    
    
    /* creates block */
//    func createBlock() -> SKSpriteNode {
//        let node = Box();
//        addChild(node);
//        return node;
//    }
    
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
        let randomTime = arc4random_uniform(15);
        let moveUp = SKAction.moveBy(x: 0, y: top.y - node.position.y, duration: TimeInterval(randomTime))
        
        let delete = SKAction.run {
            self.deleteBlock(node: node)
            if node.name == "bubble" {
                score -= Int(arc4random_uniform(4) + 1);
            }
          scoreArr[0].text = String(score);
        }
        let blockSequence = SKAction.sequence([moveUp, delete]);
        
        
        let rotate = SKAction.rotate(byAngle: angle, duration: 5);
        let rotateForever = SKAction.repeatForever(rotate);
        
        
        let actionGroup = SKAction.group([rotateForever, blockSequence]);
        node.run(actionGroup);
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
