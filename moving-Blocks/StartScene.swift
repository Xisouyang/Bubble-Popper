//
//  StartScene.swift
//  moving-Blocks
//
//  Created by Stephen Ouyang on 10/16/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import UIKit
import SpriteKit

class StartScene: SKScene {
    
    /* run this when app loads up, first screen */
    override func didMove(to view: SKView) {
        
        /* initialize arguments for label instantiation */
        let titleText: String = "Bubble Popper"
        let startButtonText: String = "Start"
        let color = UIColor.white;
        let font = "Futura-Bold";
        let fontSize: CGFloat = 40;
        let smallerFontSize: CGFloat = 20;
        let titlePosition = CGPoint(x: (self.size.width / 2), y: self.size.height * 0.8);
        let startButtonPosition = CGPoint(x: (self.size.width / 2), y: self.size.height * 0.7);
        
        print(view.scene?.size)
        
        let backgroundNode = Background()
        addChild(backgroundNode)
//        self.view?.addSubview(backgroundNode)
        
        
        /* create title label and start button */
        let titleLabel = Labels(text: titleText, color: color, fontSize: fontSize, font: font, position: titlePosition, name: "title")
        addChild(titleLabel)
        
        let startButtonLabel = Labels(text: startButtonText, color: color, fontSize: smallerFontSize, font: font, position: startButtonPosition, name: "startButton")
        addChild(startButtonLabel)
    }
    
    /* when start pressed, move to running game scene */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        if let touch = touches.first {
            let location = touch.location(in: self);
            let node = atPoint(location);
            if node.name == "startButton" {
                let skView = self.view as SKView?
                let scene = RunningGameScene();
                scene.size = (skView?.bounds.size)!;
                
                guard let targetView = self.scene?.view else {
                    print("self.scene is nil")
                    return
                }
                
                targetView.presentScene(RunningGameScene(size: self.size))
                // skView?.presentScene(scene);
            }
        }
    }

}
