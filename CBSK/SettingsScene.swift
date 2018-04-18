//
//  SettingsScene.swift
//  Curveball
//
//  Created by Jamal Hashim on 5/4/16.
//  Copyright © 2016 Jamal Hashim. All rights reserved.
//

import UIKit
import SpriteKit

class SettingsScene: SKScene {
    var screenWidth:Double=0
    var screenHeight:Double=0
    var zoom:Double=0
    let titleNode = SKLabelNode(text: "Settings")
    var menuButton:SKSpriteNode = SKSpriteNode()
    var restoreButton:SKSpriteNode = SKSpriteNode()
    var musicButton:SKSpriteNode = SKSpriteNode()
    var contactButton:SKSpriteNode = SKSpriteNode()
    var rateButton:SKSpriteNode = SKSpriteNode()
    var rateNode:SKLabelNode = SKLabelNode(text: "Like Curveball? Please ")
    var musicNode = SKLabelNode()
    override func didMove(to view: SKView) {
        
        
        self.removeAllChildren()
        
        
        
        self.scaleMode = SKSceneScaleMode.resizeFill
        //println("in")
        screenWidth=Double(view.bounds.size.width)
        screenHeight=Double(view.bounds.size.height)
        zoom = Double(view.bounds.size.width)*1.05
        
        self.backgroundColor = SKColor.black
        
        
        restoreButton = SKSpriteNode(imageNamed:"Restore")
        restoreButton.xScale = (CGFloat(screenWidth/6.5))/restoreButton.frame.width
        restoreButton.yScale=restoreButton.xScale
        //startButton.yScale = (CGFloat(screenWidth/6.5))/startButton.frame.width
        restoreButton.name="Start Button"
        restoreButton.zPosition = 1
        restoreButton.position = CGPoint(x:screenWidth * 0.5, y:screenHeight*0.3)
        restoreButton.name="unpushed"
        
        musicButton = SKSpriteNode(imageNamed:"Toggle")
        musicButton.xScale = (CGFloat(screenWidth/6.5))/musicButton.frame.width
        musicButton.yScale=musicButton.xScale
        //startButton.yScale = (CGFloat(screenWidth/6.5))/startButton.frame.width
        musicButton.name="Start Button"
        musicButton.zPosition = 1
        musicButton.position = CGPoint(x:screenWidth * 0.5, y:screenHeight*0.5)
        musicButton.name="unpushed"

        
        menuButton = SKSpriteNode(imageNamed:"BackButton")
        menuButton.xScale = (CGFloat(screenWidth/6.5))/menuButton.frame.width
        menuButton.yScale=menuButton.xScale
        menuButton.name="unpushed"
        menuButton.zPosition = 1
        menuButton.position = CGPoint(x:menuButton.frame.width/2+10, y: CGFloat(screenHeight-Double(menuButton.frame.height/2+10)))
        menuButton.name="unpushed"
        
        titleNode.fontSize = 100
        titleNode.fontName = "Arial-Bold"
        titleNode.xScale=CGFloat(screenWidth/1.8)/titleNode.frame.width
        titleNode.yScale=titleNode.xScale
        titleNode.position=CGPoint(x: screenWidth/2, y: screenHeight/1.3)
        
        rateNode.fontSize = 25
        rateNode.fontName = "Arial-Bold"
        rateNode.position=CGPoint(x: screenWidth/2, y: screenHeight * 0.1)
        rateNode.color = UIColor.white
        
        musicNode.fontSize = 25
        musicNode.fontName = "Arial-Bold"
        let controller:GameViewController = (self.view?.window?.rootViewController as! GameViewController)
        if(controller.audioPlayer?.isPlaying==true){
            musicNode.text = "Music: On"
        }
        else{
             musicNode.text = "Music: Off"
        }
        musicNode.position=CGPoint(x: CGFloat(screenWidth/2), y: CGFloat(screenHeight) * 0.5 + musicButton.frame.height/2+15)
        musicNode.color = UIColor.white
        
        rateButton = SKSpriteNode(imageNamed:"Rate")
        rateButton.xScale = (CGFloat(screenWidth/6.5))/rateButton.frame.width
        rateButton.yScale=rateButton.xScale
        rateButton.name="unpushed"
        rateButton.zPosition = 1
        rateButton.position = CGPoint(x:0, y: screenHeight * 0.1)
        rateButton.name="unpushed"

        
        
      
        
        let total = rateButton.frame.width+15+rateNode.frame.width+rateButton.frame.width/2
        let start = CGFloat(screenWidth/2)-total/2
        rateNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        rateNode.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        rateNode.position = CGPoint(x: start , y: CGFloat(screenHeight*0.1))
        //let y = CGFloat(rateButton.frame.height/2-2+CGFloat(screenHeight*0.1))
        let y = CGFloat(screenHeight*0.1)
        //.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
        rateButton.position = CGPoint(x: CGFloat(Double(rateNode.frame.width + rateNode.position.x+15+rateButton.frame.width/2)), y: y)
        
        
        self.addChild(titleNode)
        self.addChild(menuButton)
        self.addChild(restoreButton)
        self.addChild(musicButton)
        self.addChild(rateNode)
        self.addChild(rateButton)
        self.addChild(musicNode)
        //        self.addChild(noticeNode2)
        
        //self.addChild(startLabel)
        // println(SKColor.greenColor().CGColor)
        // println(SKColor.greenColor().CIColor.green())
        //println(SKColor.greenColor().CIColor.blue())
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches ) {
            let location = touch.location(in: self)
            
            if(restoreButton.contains(location)&&restoreButton.name=="unpushed"){
                restoreButton.name="pushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                restoreButton.texture = SKTexture(imageNamed: "RestorePushed")
            }

            if(menuButton.contains(location)&&menuButton.name=="unpushed"){
                menuButton.name="pushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                menuButton.texture = SKTexture(imageNamed: "BackButtonPushed")
            }
            
            if(rateButton.contains(location)&&rateButton.name=="unpushed"){
                rateButton.name="pushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                rateButton.texture = SKTexture(imageNamed: "RatePushed")
            }
            if(musicButton.contains(location)&&musicButton.name=="unpushed"){
                musicButton.name="pushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                musicButton.texture = SKTexture(imageNamed: "TogglePushed")
            }

        }
    }
    
    override func touchesMoved(_ touches:  Set<UITouch>, with event: UIEvent?) {
        
        for touch:AnyObject in touches {
            let location = touch.location(in: self)
            
            if(restoreButton.contains(location)&&restoreButton.name=="unpushed"){
                restoreButton.name="pushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                restoreButton.texture = SKTexture(imageNamed: "RestorePushed")
            }
            
            if(menuButton.contains(location)&&menuButton.name=="unpushed"){
                menuButton.name="pushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                menuButton.texture = SKTexture(imageNamed: "BackButtonPushed")
            }
            
            if(rateButton.contains(location)&&rateButton.name=="unpushed"){
                rateButton.name="pushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                rateButton.texture = SKTexture(imageNamed: "RatePushed")
            }
            if(musicButton.contains(location)&&musicButton.name=="unpushed"){
                musicButton.name="pushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                musicButton.texture = SKTexture(imageNamed: "TogglePushed")
            }
            }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches ) {
            let location = touch.location(in: self)
           
            if(restoreButton.contains(location)){
                //println("in")
                
                let alert = UIAlertController(title: "Instructions to Restore Paddles", message: "If you are transferring devices, here are instructions to restore your paddles. On your old device, if you have not already done so, log into Game Center, and restart the app, then wait for the welcome banner to show. On your new device, log in to Game Center and restart the app, and your paddles should automatically be restored.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.view?.window?.rootViewController?.present(alert, animated: false, completion: nil)
                
                restoreButton.texture = SKTexture(imageNamed: "Restore")
                restoreButton.name="unpushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
            }
            else if(restoreButton.name=="pushed"){
                restoreButton.texture = SKTexture(imageNamed: "Restore")
                restoreButton.name="unpushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
            }
            
            if(menuButton.contains(location)){
                //println("in")
            
                menuButton.texture = SKTexture(imageNamed: "BackButton")
                menuButton.name="unpushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                
                
                
                let transition = SKTransition.fade(withDuration: 0.5)
                
                let nextScene = StartScene(size: scene!.size)
                nextScene.scaleMode = .aspectFill
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                scene?.view?.presentScene(nextScene, transition: transition)
            }
            else if(menuButton.name=="pushed"){
                menuButton.texture = SKTexture(imageNamed: "BackButton")
                menuButton.name="unpushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
            }
            
            if(rateButton.contains(location)){
                //println("in")
                
                rateButton.texture = SKTexture(imageNamed: "Rate")
                rateButton.name="unpushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                let link = URL(string: "itms-apps://itunes.apple.com/app/id1070277054")
                
                UIApplication.shared.openURL(link!)
                
            }
            else if(rateButton.name=="pushed"){
                rateButton.texture = SKTexture(imageNamed: "Rate")
                rateButton.name="unpushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                
            }
            
            
            if(musicButton.contains(location)){
                //println("in")
                
                musicButton.texture = SKTexture(imageNamed: "Toggle")
                musicButton.name="unpushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                if((self.view?.window?.rootViewController as! GameViewController).audioPlayer?.isPlaying==true){
                    (self.view?.window?.rootViewController as! GameViewController).audioPlayer?.pause()
                    self.musicNode.text = "Music: Off"
                }
                else{
                    (self.view?.window?.rootViewController as! GameViewController).audioPlayer?.play()
                    self.musicNode.text = "Music: On"

                }
                
                
            }
            else if(musicButton.name=="pushed"){
                musicButton.texture = SKTexture(imageNamed: "Toggle")
                musicButton.name="unpushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
            }
            

            
            
        }
    }
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        
        

}
}
