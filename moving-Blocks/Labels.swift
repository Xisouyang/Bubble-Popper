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
        
    
    init(text: String, color: UIColor, fontSize: CGFloat, font: String, position: CGPoint) {
        super.init()
        self.text = text;
        self.color = color;
        self.fontSize = fontSize;
        self.fontName = font;
        self.position = position;
                
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
