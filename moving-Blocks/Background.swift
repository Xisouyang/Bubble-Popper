//
//  Background.swift
//  moving-Blocks
//
//  Created by Stephen Ouyang on 10/19/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import UIKit
import SpriteKit

class Background: SKSpriteNode {
    
    var screenSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    
    init(){
        super.init(texture: nil, color: .clear, size: screenSize)
        self.texture = SKTexture(imageNamed: "underwater-background-asset")
        self.position = CGPoint(x: size.width/2, y: size.height/2)
        self.zPosition = -1
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
