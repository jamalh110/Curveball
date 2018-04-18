//
//  WinScene.swift
//  CBSK
//
//  Created by Jamal Hashim on 11/5/15.
//  Copyright (c) 2018 Jamal Hashim. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit

class WinSceneHard: SKScene {
    var screenWidth:Double=0
    var screenHeight:Double=0
    var zoom:Double=0
    var retryButton:SKSpriteNode = SKSpriteNode()
    var retryButtonPushed:SKSpriteNode = SKSpriteNode()
    var menuButton:SKSpriteNode = SKSpriteNode()
    var menuButtonPushed:SKSpriteNode = SKSpriteNode()
    let levelLabel = SKLabelNode(text: ("Levels Completed: " + String(variables.level-1)))
    let scoreLabel = SKLabelNode(text: ("Score: " + String(variables.scoreHard)))
    let gameOverNode = SKLabelNode(text: "You Beat All 10 Levels")
    let gameOverNode2 = SKLabelNode(text: "Now Try To Get A Higher Score")
    override func didMove(to view: SKView) {
        
        
        let leaderboardID = "grp.curveballhighscorehard"
        let sScore = GKScore(leaderboardIdentifier: leaderboardID)
        sScore.value = Int64(variables.scoreHard)
        
        let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
        if(localPlayer.isAuthenticated){
            GKScore.report([sScore], withCompletionHandler: { (error: Error?) -> Void in
                if error != nil {
                    // print(error!.localizedDescription)
                } else {
                    //print("Score submitted")
                    
                }
                } as! (Error?) -> Void)
        }
        
        if(variables.highLevel<variables.level-1){
            variables.highLevel=variables.level-1
        }
        if(variables.highScoreHard<variables.scoreHard){
            variables.highScoreHard=variables.scoreHard
        }
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths[0]
        let filePath =  (documentDirectory as NSString).appendingPathComponent("CBSKData3.plist")
        //println(variables.gems)
        var gameData:GameData
        
        gameData = GameData(gems: variables.gems, level: variables.highLevel, score: variables.highScore, paddle: Data.getPaddle(), skull: variables.skull, fractal: variables.fractal, infinity: variables.infinity, mustache: variables.mustache, ultimate: variables.ultimate, cross: variables.cross, scoreHard: variables.highScoreHard)
        NSKeyedArchiver.archiveRootObject(gameData, toFile: filePath)
        self.removeAllChildren()
        self.scaleMode = SKSceneScaleMode.resizeFill
        //println("in")
        screenWidth=Double(view.bounds.size.width)
        screenHeight=Double(view.bounds.size.height)
        zoom = Double(view.bounds.size.width)*1.05
        
        self.backgroundColor = SKColor.black
        
        levelLabel.fontName = "Arial-Bold"
        levelLabel.horizontalAlignmentMode = .center
        levelLabel.verticalAlignmentMode = .center
        levelLabel.position = CGPoint(x: screenWidth/2, y: screenHeight/1.8)
        
        scoreLabel.fontName = "Arial-Bold"
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.verticalAlignmentMode = .center
        scoreLabel.position = CGPoint(x: screenWidth/2, y: screenHeight/2.4)
        
        gameOverNode.fontSize = 100
        gameOverNode.fontName = "Arial-Bold"
        gameOverNode.xScale=CGFloat(screenWidth/1.6)/gameOverNode.frame.width
        gameOverNode.yScale=gameOverNode.xScale
        gameOverNode.verticalAlignmentMode = .center
        gameOverNode.position=CGPoint(x: screenWidth/2, y: screenHeight/1.3)
        
        gameOverNode2.fontSize = 100
        gameOverNode2.fontName = "Arial-Bold"
        gameOverNode2.xScale=CGFloat(screenWidth/1.6)/gameOverNode2.frame.width
        gameOverNode2.yScale=gameOverNode2.xScale
        gameOverNode2.verticalAlignmentMode = .center
        gameOverNode2.position=CGPoint(x: screenWidth/2, y: screenHeight/1.6)
        
        menuButton = SKSpriteNode(imageNamed:"MenuButton")
        menuButton.xScale = (CGFloat(screenWidth/6.5))/menuButton.frame.width
        menuButton.yScale=menuButton.xScale
        menuButton.name="Menu Button"
        menuButton.zPosition = 1
        menuButton.position = CGPoint(x:screenWidth/2.5, y:screenHeight/3.8)
        
        menuButtonPushed = SKSpriteNode(imageNamed:"MenuButtonPushed")
        menuButtonPushed.xScale = (CGFloat(screenWidth/6.5))/menuButtonPushed.frame.width
        menuButtonPushed.yScale=menuButtonPushed.xScale
        menuButtonPushed.name="Menu Button Pushed"
        menuButtonPushed.zPosition = 1
        menuButtonPushed.position = CGPoint(x:screenWidth/2.5, y:screenHeight/3.8)
        
        
        retryButton = SKSpriteNode(imageNamed:"PlayAgainButton")
        retryButton.xScale = (CGFloat(screenWidth/6.5))/retryButton.frame.width
        retryButton.yScale=retryButton.xScale
        retryButton.name="Retry Button"
        retryButton.zPosition = 1
        retryButton.position = CGPoint(x:screenWidth/1.666, y:screenHeight/3.8)
        
        retryButtonPushed = SKSpriteNode(imageNamed:"PlayAgainButtonPushed")
        retryButtonPushed.xScale = (CGFloat(screenWidth/6.5))/retryButtonPushed.frame.width
        retryButtonPushed.yScale=retryButtonPushed.xScale
        retryButtonPushed.name="Retry Button Pushed"
        retryButtonPushed.zPosition = 1
        retryButtonPushed.position = CGPoint(x:screenWidth/1.666, y:screenHeight/3.8)
        
        self.addChild(menuButton)
        self.addChild(retryButton)
        //self.addChild(levelLabel)
        self.addChild(gameOverNode)
        self.addChild(gameOverNode2)
        self.addChild(scoreLabel)
        //self.addChild(startLabel)
        // println(SKColor.greenColor().CGColor)
        // println(SKColor.greenColor().CIColor.green())
        //println(SKColor.greenColor().CIColor.blue())
        let rect=Rect3D(x: -3, y: -2, z: 8, width: 6, height: 4, back: 0)
        self.addChild(rect.rectNodeXY(Double(view.bounds.size.width),screeny: Double(view.bounds.size.height), zoom: zoom))
        let rect2=Rect3D(x: -3, y: -2, z: 10, width: 6, height: 4, back: 0)
        self.addChild(rect2.rectNodeXY(Double(view.bounds.size.width),screeny: Double(view.bounds.size.height), zoom: zoom))
        let rect3=Rect3D(x: -3, y: -2, z: 12, width: 6, height: 4, back: 0)
        self.addChild(rect3.rectNodeXY(Double(view.bounds.size.width),screeny: Double(view.bounds.size.height), zoom: zoom))
        let rect4=Rect3D(x: -3, y: -2, z: 14, width: 6, height: 4, back: 0)
        self.addChild(rect4.rectNodeXY(Double(view.bounds.size.width),screeny: Double(view.bounds.size.height), zoom: zoom))
        let rect5=Rect3D(x: -3, y: -2, z: 16, width: 6, height: 4, back: 0)
        self.addChild(rect5.rectNodeXY(Double(view.bounds.size.width),screeny: Double(view.bounds.size.height), zoom: zoom))
        let rect6=Rect3D(x: -3, y: -2, z: 18, width: 6, height: 4, back: 0)
        self.addChild(rect6.rectNodeXY(Double(view.bounds.size.width),screeny: Double(view.bounds.size.height), zoom: zoom))
        let rect7=Rect3D(x: -3, y: -2, z: 20, width: 6, height: 4, back: 0)
        self.addChild(rect7.rectNodeXY(Double(view.bounds.size.width),screeny: Double(view.bounds.size.height), zoom: zoom))
        let rect8=Rect3D(x: -3, y: -2, z: 22, width: 6, height: 4, back: 0)
        self.addChild(rect8.rectNodeXY(Double(view.bounds.size.width),screeny: Double(view.bounds.size.height), zoom: zoom))
        let rect9=Rect3D(x: -3, y: -2, z: 24, width: 6, height: 4, back: 0)
        self.addChild(rect9.rectNodeXY(Double(view.bounds.size.width),screeny: Double(view.bounds.size.height), zoom: zoom))
        let line1=Line3D(x: -3, y: -2, z: 8, x2: -3, y2: -2, z2: 24)
        self.addChild(line1.lineNode(Double(view.bounds.size.width),screeny: Double(view.bounds.size.height), zoom: zoom))
        let line2=Line3D(x: 3, y: -2, z: 8, x2: 3, y2: -2, z2: 24)
        self.addChild(line2.lineNode(Double(view.bounds.size.width),screeny: Double(view.bounds.size.height), zoom: zoom))
        let line3=Line3D(x: 3, y: 2, z: 8, x2: 3, y2: 2, z2: 24)
        self.addChild(line3.lineNode(Double(view.bounds.size.width),screeny: Double(view.bounds.size.height), zoom: zoom))
        let line4=Line3D(x: -3, y: 2, z: 8, x2: -3, y2: 2, z2: 24)
        self.addChild(line4.lineNode(Double(view.bounds.size.width),screeny: Double(view.bounds.size.height), zoom: zoom))
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches ) {
            let location = touch.location(in: self)
            
            if(menuButton.contains(location)){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                menuButton.removeFromParent()
                self.addChild(menuButtonPushed)
            }
            if(retryButton.contains(location)){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                retryButton.removeFromParent()
                self.addChild(retryButtonPushed)
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
            if(retryButton.contains(location)&&retryButtonPushed.parent != self){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                retryButton.removeFromParent()
                self.addChild(retryButtonPushed)
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
            if(retryButton.contains(location)){
                retryButtonPushed.removeFromParent()
                self.addChild(retryButton)
                //println("in")
                let transition = SKTransition.fade(withDuration: 0.5)
                
                let nextScene = GameScene(size: scene!.size)
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
            else if(retryButtonPushed.parent==self){
                retryButtonPushed.removeFromParent()
                if(retryButton.parent != self){
                    self.addChild(retryButton)
                }
            }
        }
    }
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        
        
    }
}
