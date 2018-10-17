//
//  Labels.swift
//  moving-Blocks
//
//  Created by Stephen Ouyang on 9/29/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import UIKit
import SpriteKit

class Labels: SKLabelNode {
        
    init(text: String, color: UIColor, fontSize: CGFloat, font: String, position: CGPoint, name: String) {
        super.init()
        self.text = text;
        self.color = color;
        self.fontSize = fontSize;
        self.fontName = font;
        self.position = position;
        self.name = name;
    }
    
    
    /* Fades the point labels */
    func pointLabelAction() {
        let fadeDuration = 0.75;
        let point = self;
        
        let fade = SKAction.fadeOut(withDuration: TimeInterval(fadeDuration));
        let remove = SKAction.run {
            point.removeFromParent();
        }
        let labelSequence = SKAction.sequence([fade, remove])
        point.run(labelSequence);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
