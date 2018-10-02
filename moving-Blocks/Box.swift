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
    let random = arc4random_uniform(50);
    var buffer = 100;
    let gameInstance = RunningGameScene();
    
    
    func randomColor() -> UIColor {
        let colorArr : [UIColor] = [.blue, .cyan, .yellow, .green, .orange, .purple, .red ]
        return colorArr[Int(arc4random_uniform(7))];
    }
    
    init(view: SKView) {
        super.init(texture: nil, color: .red, size: CGSize(width: CGFloat(random) + 10, height: CGFloat(random) + 10))
        name = "block";
        color = randomColor();
        position.x = CGFloat(arc4random_uniform(UInt32((view.scene?.size.width)!)));
        position.y = CGFloat(arc4random_uniform(UInt32((view.scene?.size.height)!))) - CGFloat(buffer);
        
        if position.y > 500 || position.y < 100 {
            position.y = CGFloat(arc4random_uniform(300) + 50);
//            print("working y");
//            print(position.x)
//            print(position.y)

        }
        
        if position.x > 370 || position.x < 30 {
            position.y = CGFloat(arc4random_uniform(200) + 50);
//            print("working x");
//            print(position.x)
//            print(position.y)
        }
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
        let randomTime = arc4random_uniform(10);
        let moveUp = SKAction.moveBy(x: 0, y: top.y - node.position.y, duration: TimeInterval(randomTime))
        
        let delete = SKAction.run {
            self.deleteBlock(node: node)
            score -= 1;
            
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
