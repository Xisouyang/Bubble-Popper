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
        self.texture = SKTexture(imageNamed: "background")
        self.position = CGPoint(x: size.width/2, y: size.height/2)
        self.zPosition = -1
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//class otherBackground: UIImageView {
//
//    var screenSize = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//
//    init() {
//        super.init(frame: screenSize)
//        self.image = UIImage(named: "background")
//        self.contentMode = UIViewContentMode.scaleAspectFill
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
