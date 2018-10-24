//
//  Buttons.swift
//  moving-Blocks
//
//  Created by Stephen Ouyang on 10/18/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import UIKit
import SpriteKit

class Buttons: SKSpriteNode {
    
    init(texture: SKTexture, position: CGPoint, isHidden: Bool, name: String) {
        super.init(texture: nil, color: .black, size: CGSize(width: 10, height: 10))
        self.texture = texture
        self.size = CGSize(width: 30, height: 30)
        self.position = position
        self.isHidden = isHidden
        self.name = name
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
