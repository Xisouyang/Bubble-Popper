//
//  EndGameScene.swift
//  moving-Blocks
//
//  Created by Stephen Ouyang on 9/20/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import SpriteKit
import GameplayKit

//Ends the game
class EndGameScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        let background = Background()
        addChild(background)
        
        let endName = "OverLabel"
        let restartName: String? = "ReplayLabel"
        let fontSize: CGFloat = 40;
        let smallerFontSize: CGFloat = 20;
        let endText = "Game Over";
        let restartText = "Restart";
        let color = UIColor.white;
        let font = "Futura-Bold";
        let endPosition = CGPoint(x: (self.size.width / 2), y: self.size.height * 0.85);
        let restartPosition = CGPoint(x: (self.size.width / 2), y: self.size.height * 0.75);
        
        let endLabel = Labels(text: endText, color: color, fontSize: fontSize, font: font, position: endPosition, name: endName);
        addChild(endLabel)
        
        let restartLabel = Labels(text: restartText, color: .white, fontSize: smallerFontSize, font: font, position: restartPosition, name: restartName!);
        addChild(restartLabel)
    }
    
    /* if user touches restart, restarts the game */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        if let touch = touches.first {
            let location = touch.location(in: self);
            let node = atPoint(location);
            if node.name == "ReplayLabel" {
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
