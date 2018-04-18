//
//  GameScene.swift
//  CBSK
//
//  Created by Jamal Hashim on 9/29/15.
//  Copyright (c) 2015 Jamal Hashim. All rights reserved.
//

import SpriteKit
import GameKit
class MultiplayerScene: SKScene {
    var screenWidth:Double=0
    var screenHeight:Double=0
    var zoom:Double=0
    var autoButton:SKSpriteNode = SKSpriteNode()
    var autoButtonPushed:SKSpriteNode = SKSpriteNode()
    var menuButton:SKSpriteNode = SKSpriteNode()
    var menuButtonPushed:SKSpriteNode = SKSpriteNode()
    let titleNode = SKLabelNode(text: "Multiplayer")
    let noticeNode1 = SKLabelNode(text: "If you and a friend press Random Match at the same time, you should get paired")
    let noticeNode2 = SKLabelNode(text: "You are either not logged into Game Center or do not have internet")
    let GemsLabel = SKLabelNode(text: "Win = 10")
    let gemSprite = SKSpriteNode(imageNamed: "GemOpaque")
    
    
    
    override func didMove(to view: SKView) {
        
        
        self.removeAllChildren()
        
        
       
        self.scaleMode = SKSceneScaleMode.resizeFill
        //println("in")
        screenWidth=Double(view.bounds.size.width)
        screenHeight=Double(view.bounds.size.height)
        zoom = Double(view.bounds.size.width)*1.05
        
        self.backgroundColor = SKColor.black
        
        menuButton = SKSpriteNode(imageNamed:"BackButton")
        menuButton.xScale = (CGFloat(screenWidth/6.5))/menuButton.frame.width
        menuButton.yScale=menuButton.xScale
        menuButton.name="Menu Button"
        menuButton.zPosition = 1
        menuButton.position = CGPoint(x:menuButton.frame.width/2+10, y: CGFloat(screenHeight-Double(menuButton.frame.height/2+10)))
        
        menuButtonPushed = SKSpriteNode(imageNamed:"BackButtonPushed")
        menuButtonPushed.xScale = (CGFloat(screenWidth/6.5))/menuButtonPushed.frame.width
        menuButtonPushed.yScale=menuButtonPushed.xScale
        menuButtonPushed.name="Menu Button Pushed"
        menuButtonPushed.zPosition = 1
        menuButtonPushed.position = CGPoint(x:menuButton.frame.width/2+10, y: CGFloat(screenHeight-Double(menuButton.frame.height/2+10)))
        
        
        autoButton = SKSpriteNode(imageNamed:"Random")
        autoButton.xScale = (CGFloat(screenWidth/6.5))/autoButton.frame.width
        autoButton.yScale=autoButton.xScale
        autoButton.name="Retry Button"
        autoButton.zPosition = 1
        autoButton.position = CGPoint(x:screenWidth/2, y:screenHeight/1.8)
        
        autoButtonPushed = SKSpriteNode(imageNamed:"RandomPushed")
        autoButtonPushed.xScale = (CGFloat(screenWidth/6.5))/autoButtonPushed.frame.width
        autoButtonPushed.yScale=autoButtonPushed.xScale
        autoButtonPushed.name="Retry Button Pushed"
        autoButtonPushed.zPosition = 1
        autoButtonPushed.position = CGPoint(x:screenWidth/2, y:screenHeight/1.8)
        
        titleNode.fontSize = 100
        titleNode.fontName = "Arial-Bold"
        titleNode.xScale=CGFloat(screenWidth/1.6)/titleNode.frame.width
        titleNode.yScale=titleNode.xScale
        titleNode.position=CGPoint(x: screenWidth/2, y: screenHeight/1.4)
        
        noticeNode1.fontSize = 12
        noticeNode1.fontName = "Arial-Bold"
       // noticeNode1.xScale=CGFloat(screenWidth/1.3)/noticeNode1.frame.width
        //noticeNode1.yScale=noticeNode1.xScale
        noticeNode1.position=CGPoint(x: screenWidth/2, y: screenHeight/2.4)
        
        noticeNode2.fontSize = 14
        noticeNode2.fontName = "Arial-Bold"
        // noticeNde1.xScale=CGFloat(screenWidth/1.3)/noticeNode1.frame.width
        //noticeNode1.yScale=noticeNode1.xScale
        noticeNode2.position=CGPoint(x: screenWidth/2, y: screenHeight/3)
        
        GemsLabel.fontSize = 20
        GemsLabel.fontName = "Arial-Bold"
        GemsLabel.position =  CGPoint(x: screenWidth/2, y: screenHeight*0.2)
        GemsLabel.color = SKColor.white
        
        gemSprite.xScale = 20/gemSprite.frame.width
        gemSprite.yScale=gemSprite.xScale
        gemSprite.position = CGPoint(x: CGFloat(Double(GemsLabel.frame.width+10+15)), y: CGFloat(screenHeight-Double(GemsLabel.frame.height/2+10)))

        
        let total = gemSprite.frame.width+15+GemsLabel.frame.width
        let start = CGFloat(screenWidth/2)-total/2
        GemsLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        GemsLabel.position = CGPoint(x: start , y: CGFloat(screenHeight*0.2))
        let y = CGFloat(gemSprite.frame.height/2-2+CGFloat(screenHeight*0.2))
        gemSprite.position = CGPoint(x: CGFloat(Double(GemsLabel.frame.width + GemsLabel.position.x+15)), y: y)
        
        self.addChild(gemSprite)
        self.addChild(GemsLabel)
        self.addChild(menuButton)
        self.addChild(autoButton)
        self.addChild(titleNode)
        self.addChild(noticeNode1)
//        self.addChild(noticeNode2)
        
        //self.addChild(startLabel)
        // println(SKColor.greenColor().CGColor)
        // println(SKColor.greenColor().CIColor.green())
        //println(SKColor.greenColor().CIColor.blue())
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches ) {
            let location = touch.location(in: self)
            
            if(menuButton.contains(location)){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                menuButton.removeFromParent()
                self.addChild(menuButtonPushed)
            }
            if(autoButton.contains(location)){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                autoButton.removeFromParent()
                self.addChild(autoButtonPushed)
            }
        }
    }
    
    override func touchesMoved(_ touches:  Set<UITouch>, with event: UIEvent?) {
        
        for touch:AnyObject in touches {
            let location = touch.location(in: self)
            if(menuButton.contains(location)&&menuButtonPushed.parent != self){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                menuButton.removeFromParent()
                self.addChild(menuButtonPushed)
            }
            if(autoButton.contains(location)&&autoButtonPushed.parent != self){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                autoButton.removeFromParent()
                self.addChild(autoButtonPushed)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches ) {
            let location = touch.location(in: self)
            
            if(menuButtonPushed.contains(location)){
                // println("in")
                menuButtonPushed.removeFromParent()
                self.addChild(menuButton)
                let transition = SKTransition.fade(withDuration: 0.5)
                
                let nextScene = StartScene(size: scene!.size)
                nextScene.scaleMode = .aspectFill
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                scene?.view?.presentScene(nextScene, transition: transition)
            }
            else if(menuButtonPushed.parent==self){
                menuButtonPushed.removeFromParent()
                if(menuButton.parent != self){
                self.addChild(menuButton)
                }
            }
            if(autoButton.contains(location)){
                autoButtonPushed.removeFromParent()
                self.addChild(autoButton)
                //println("in")
                if(GKLocalPlayer.localPlayer().isAuthenticated){
                let transition = SKTransition.fade(withDuration: 0.5)
                
                let nextScene = MatchScene(size: scene!.size)
                nextScene.scaleMode = .aspectFill
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                scene?.view?.presentScene(nextScene, transition: transition)
                }
                else if(noticeNode2.parent != self){
                    self.addChild(noticeNode2)
                    GKLocalPlayer.localPlayer().authenticateHandler = {(viewController : UIViewController?, error : Error?) -> Void in
                        if ((viewController) != nil) {
                            //self.presentViewController(viewController, animated: true, completion: nil)
                        }else{
                            
                            //println((GKLocalPlayer.localPlayer().authenticated))
                        }
                    } as! (UIViewController?, Error?) -> Void

                    
                }
            }
            
            else if(autoButtonPushed.parent==self){
                autoButtonPushed.removeFromParent()
                if(autoButton.parent != self){
                self.addChild(autoButton)
                }
            }
        }
    }
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        
        
    }
}



