//
//  GameScene.swift
//  Game-Starter-Empty
//
//  Created by mitchell hudson on 9/13/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import SpriteKit
import GameplayKit

/* Neccessary global variables - accessed in Box.swift */
var score = 1;
var scoreArr: [SKLabelNode] = [];

/* Instantiated as global variable so can access in the touch methods below */
private var pauseButton: Buttons?

/* Keep track of game state */
enum GameState {
    case play
    case pause
}

var state: GameState = .play

class RunningGameScene: SKScene {
    
    // Called when the scene has been displayed
    override func didMove(to view: SKView) {
        
        let background = Background()
        addChild(background)
        
        /* Need to restart the game */
        scoreArr = [];
        score = 1;
        
        /* Add neccessary elements */
        scoreLabel()
        createStateButtons()
        
        /* starts the game */
        let delay = SKAction.wait(forDuration: 1);
        let runSequence = SKAction.run {
            self.startSequence();
        }
        let start = SKAction.sequence([delay, runSequence]);
        let goForev = SKAction.repeatForever(start);
        self.run(goForev);
    }
    
    
    /* creates block, start actions */
    func startSequence() {
        let node = Box(view: self.view!);
        addChild(node);
        node.blockActions(node: node);
    }
    
    /* create score label */
    func scoreLabel() {
        let score = Labels(text: "1", color: .white, fontSize: 40, font: "Futura-Bold", position: CGPoint(x: (self.size.width / 2), y: self.size.height * 0.8), name: "scoreLabel");
//        score.zPosition = 4;
        scoreArr.append(score);
        addChild(score);
    }
    
    func createStateButtons() {
        
        let position = CGPoint(x: (self.size.width * 0.9), y: self.size.height * 0.9);
        let size = CGSize(width: 40, height: 40)
        pauseButton = Buttons(texture: SKTexture(imageNamed: "pause-asset"), position: position, isHidden: false, name: "pauseButton")
        
        addChild(pauseButton!)
    }
    
    /* Bigger bubbles score less points */
    func addPoint(node: SKSpriteNode) -> String {
        let size = node.size
        var pointStr = "1"
        
        switch size {
        case let size where size.width >= CGFloat(20) && size.width < CGFloat(30):
            pointStr = String(4)
            break
        case let size where size.width >= CGFloat(30) && size.width < CGFloat(40):
            pointStr = String(3)
            break
        case let size where size.width >= CGFloat(40) && size.width <= CGFloat(50):
            pointStr = String(2)
            break
        default:
            print("error")
        }
        return pointStr
    }
    
    /* helper function to add point labels when user successfully clicks node */
    func addPointLabel(node: SKSpriteNode) -> String {
        
        /* instantiate arguments for label initialization */
        let addition = "+";
        let pointsStr = addPoint(node: node)
        let buffer: CGFloat = 25;
        let aNode = node;
        aNode.position.x = aNode.position.x - buffer;
        
        /* create point label */
        let pointLabel = Labels(text: (addition + pointsStr), color: .white, fontSize: 25, font: "Futura-Bold", position: aNode.position, name: "addPointsLabel");
        addChild(pointLabel);
        pointLabel.pointLabelAction();
        
        return pointsStr;
    }
    
    /* same as add^ but opposite */
    func subtractPointLabel(node: SKSpriteNode) -> String {
        let subtraction = "-";
        let pointsStr = String(arc4random_uniform(4) + 1)
        let buffer: CGFloat = 25;
        let aNode = node;
        aNode.position.x = aNode.position.x - buffer;
        
        let pointLabel = Labels(text: (subtraction + pointsStr), color: .white, fontSize: 25, font: "Futura-Bold", position: aNode.position, name: "addPointsLabel");
        addChild(pointLabel);
        pointLabel.pointLabelAction();
        
        return pointsStr;
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if score == 0 || score < 0 {
            self.scene?.view?.presentScene(EndGameScene(size: self.size))
        }
    }
    
    /*
       - when bubble touched, delete bubble and increase score
       - when mine touched, delete mine and decrease score
       - when pause button touched, pause game, then continue game when play button touched
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if state == .play {
            if let touch = touches.first {
                let location = touch.location(in: self);
                let node = atPoint(location);
                
                if node.name == "bubble" {
                    node.removeFromParent();
                    let pointStr = addPointLabel(node: node as! SKSpriteNode)
                    score += Int(pointStr)!;
                    scoreArr[0].text = String(score);
                    
                } else if node.name == "bomb" {
                    node.removeFromParent()
                    let pointStr = subtractPointLabel(node: node as! SKSpriteNode)
                    score -= Int(pointStr)!
                    scoreArr[0].text = String(score)
                }
                
                if node.name == "pauseButton" {
                    let pauseState = SKAction.run {
                        state = .pause
                        self.view?.isPaused = true
                    }
                    let changeTexture = SKAction.setTexture(SKTexture(imageNamed: "play-asset"))
                    var whenPaused = SKAction.sequence([changeTexture, pauseState])
                    pauseButton?.run(whenPaused)
                }
            }
        } else if state == .pause {
            if let touch = touches.first {
                let location = touch.location(in: self)
                let node = atPoint(location)
                // button. SKTexture (name" )
                
                
                if node.name == "pauseButton" {
                    pauseButton?.texture = SKTexture(imageNamed: "pause-asset")
                    self.view?.isPaused = false
                    state = .play
                }
            }
        }
    }
}

//        let test = Labels(text: "test", color: .white, fontSize: 20, font: "Futura-Bold", position: CGPoint(x: (self.size.width / 2), y: 550), name: "testLabel")
//        test.zPosition = 3;
//        addChild(test)

//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font names: \(names)")
//        }
