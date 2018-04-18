//
//  AboutScene.swift
//  Curveball
//
//  Created by Jamal Hashim on 1/6/16.
//  Copyright (c) 2016 Jamal Hashim. All rights reserved.
//

import UIKit
import SpriteKit
class AboutScene: SKScene {
    var menuButton:SKSpriteNode = SKSpriteNode()
    var menuButtonPushed:SKSpriteNode = SKSpriteNode()
    var screenWidth:Double=0
    var screenHeight:Double=0
    var zoom:Double=0
    var picNode = SKSpriteNode(imageNamed: "HowToPlay")
    override func didMove(to view: SKView) {
        self.scaleMode = SKSceneScaleMode.resizeFill
        self.backgroundColor=SKColor.black
        screenWidth=Double(view.bounds.size.width)
        screenHeight = Double(view.bounds.size.height)
        zoom = Double(view.bounds.size.width)*1.05
        menuButton = SKSpriteNode(imageNamed:"BackButton")
        menuButton.xScale = (CGFloat(screenWidth/6.5))/menuButton.frame.width
        menuButton.yScale=menuButton.xScale
        menuButton.name="Menu Button"
        menuButton.zPosition = 1
        menuButton.position = CGPoint(x:menuButton.frame.width/2+10, y: CGFloat(Double(screenHeight)-Double(menuButton.frame.height/2+10)))
        
        menuButtonPushed = SKSpriteNode(imageNamed:"BackButtonPushed")
        menuButtonPushed.xScale = (CGFloat(screenWidth/6.5))/menuButtonPushed.frame.width
        menuButtonPushed.yScale=menuButtonPushed.xScale
        menuButtonPushed.name="Menu Button Pushed"
        menuButtonPushed.zPosition = 1
        menuButtonPushed.position = CGPoint(x:menuButton.frame.width/2+10, y: CGFloat(Double(screenHeight)-Double(menuButton.frame.height/2+10)))
        
        
        picNode.xScale = (CGFloat(screenWidth/1))/picNode.frame.width
        picNode.yScale = (CGFloat(screenHeight/1))/picNode.frame.height
        picNode.position = CGPoint(x: screenWidth/2, y: screenHeight/2)
        self.addChild(picNode)
        self.addChild(menuButton)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        for touch:AnyObject in touches {
            let location = touch.location(in: self)
            if(menuButton.contains(location)){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                menuButton.removeFromParent()
                self.addChild(menuButtonPushed)
            }
        }
        
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch:AnyObject in touches {
            let location = touch.location(in: self)
            
            
            let touchedNode = atPoint(location)
            
            if(menuButton.contains(location)&&menuButtonPushed.parent != self){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                menuButton.removeFromParent()
                self.addChild(menuButtonPushed)
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
       
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
        }
        
        
    }

}
