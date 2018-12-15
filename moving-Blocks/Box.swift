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
    let screenHeight = CGPoint(x: 0, y: UIScreen.main.bounds.height * 0.95);
    let screenWidth = CGPoint(x: UIScreen.main.bounds.width * 0.95, y: 0)
    let angle : CGFloat = 30;
    let random = arc4random_uniform(30);
    var buffer = 100;
    let gameInstance = RunningGameScene();
    
    /* returns random color to decide whether node spawned is bubble or mine */
    func randomColor() -> UIColor {
        let colorArr : [UIColor] = [.red, .blue, .blue]
        return colorArr[Int(arc4random_uniform(3))];
    }
    
    init(view: SKView) {
        super.init(texture: nil, color: .red, size: CGSize(width: CGFloat(random) + 20, height: CGFloat(random) + 20))
        
        let mineTexture = SKTexture(imageNamed: "water_mine_glare")
        let bubbleTexure = SKTexture(imageNamed: "blue-bubble-asset")
        
        color = randomColor();
        
        /* decide bubble or mine */
        if color == .red {
            texture = mineTexture
            name = "bomb"
        } else {
            texture = bubbleTexure
            name = "bubble"
        }
        
        /* where node spawns on screen */
        let position = CGPoint(x: CGFloat(arc4random_uniform(UInt32(screenWidth.x * 0.9)) + 20), y: CGFloat(arc4random_uniform(UInt32(screenHeight.y * 0.2))))
       self.position = position        
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
        let randomTime = arc4random_uniform(15);
        let moveUp = SKAction.moveBy(x: 0, y: screenHeight.y - node.position.y, duration: TimeInterval(randomTime))
        
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
