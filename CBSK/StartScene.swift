//
//  GameScene.swift
//  CBSK
//
//  Created by Jamal Hashim on 9/29/15.
//  Copyright (c) 2015 Jamal Hashim. All rights reserved.
//

import SpriteKit
import GameKit
class StartScene: SKScene, GKGameCenterControllerDelegate {
    var screenWidth:Double=0
    var screenHeight:Double=0
    var zoom:Double=0
    var startButton:SKSpriteNode = SKSpriteNode()
    var startButtonPushed:SKSpriteNode = SKSpriteNode()
    var multiButton:SKSpriteNode = SKSpriteNode()
    var multiButtonPushed:SKSpriteNode = SKSpriteNode()
    var paddleButton:SKSpriteNode = SKSpriteNode()
    var paddleButtonPushed:SKSpriteNode = SKSpriteNode()
    var aboutButton:SKSpriteNode = SKSpriteNode()
    var aboutButtonPushed:SKSpriteNode = SKSpriteNode()
    let titleNode = SKLabelNode(text: "Curveball")
    var startLabel:SKLabelNode = SKLabelNode()
    let highScoreLabel = SKLabelNode(text: "Highscore: " + String(variables.highScore))
    let hardHighScoreLabel = SKLabelNode(text: "Hard Highscore: " + String(variables.highScoreHard))
    let gemsNode = SKLabelNode(text: String(variables.gems))
    let gemSprite = SKSpriteNode(imageNamed: "GemOpaque")
    var leaderboardButton:SKSpriteNode = SKSpriteNode()
    var rateButton:SKSpriteNode = SKSpriteNode()
    var hardButton:SKSpriteNode = SKSpriteNode()
    let note1 = SKLabelNode(text: "Like Curveball? Feel free to rate and share with your friends,")
    let note2 = SKLabelNode(text: "Every bit of support is greatly appreciated!")
    
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController)
    {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    override func didMove(to view: SKView) {
        print(scene?.size.width)
        print(view.bounds.size.width)
        print(scene!.view!.bounds.size.width)
        var leaderboardID = "grp.curveballhighscore"
        var sScore = GKScore(leaderboardIdentifier: leaderboardID)
        sScore.value = Int64(variables.highScore)
        
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
        
        leaderboardID = "grp.curveballhighscorehard"
        sScore = GKScore(leaderboardIdentifier: leaderboardID)
        sScore.value = Int64(variables.highScoreHard)
        
        
        if(localPlayer.isAuthenticated){
            GKScore.report([sScore], withCompletionHandler: { (error: Error?) -> Void in
                if error != nil {
                    // print(error!.localizedDescription)
                } else {
                    //print("Score submitted")
                    
                }
                } as! (Error?) -> Void)
        }
        /*var decoder = NSKeyedUnarchiver(forReadingWithData: NSData())
        var coder = NSKeyedArchiver(forWritingWithMutableData: NSMutableData())
        coder.encodeInt(10, forKey: "Something")
        println(coder.containsValueForKey("Something"))*/
        //println(NSKeyedUnarchiver().containsValueForKey("a"))
        
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
        highScoreLabel.fontSize = 20
        highScoreLabel.fontName = "Arial-Bold"
        highScoreLabel.verticalAlignmentMode = .center
        highScoreLabel.position = CGPoint(x: CGFloat(screenWidth-Double(highScoreLabel.frame.width/2+30)), y: CGFloat(screenHeight-Double(highScoreLabel.frame.height/2+10)))
        
        gemsNode.fontSize = 20
        gemsNode.fontName = "Arial-Bold"
        gemsNode.verticalAlignmentMode = .center
        gemsNode.position = CGPoint(x: CGFloat(Double(gemsNode.frame.width/2+10)), y: CGFloat(screenHeight-Double(gemsNode.frame.height/2+10)))
        
        gemSprite.xScale = 20/gemSprite.frame.width
        gemSprite.yScale=gemSprite.xScale
        gemSprite.position = CGPoint(x: CGFloat(Double(gemsNode.frame.width+10+15)), y: CGFloat(screenHeight-Double(gemsNode.frame.height/2+10)))

        
        hardHighScoreLabel.fontSize = 20
        hardHighScoreLabel.fontName = "Arial-Bold"
        hardHighScoreLabel.verticalAlignmentMode = .center
        hardHighScoreLabel.horizontalAlignmentMode = .left
        hardHighScoreLabel.position = CGPoint(x: gemSprite.frame.maxX+20, y: highScoreLabel.position.y)
        
        startLabel = SKLabelNode(text: "Start")
        startLabel.fontSize=20
        startLabel.verticalAlignmentMode = .center
        startLabel.horizontalAlignmentMode = .center
        startLabel.position = CGPoint(x:screenWidth/2, y:screenHeight/2)
        startLabel.zPosition=1
        
        titleNode.fontSize = 100
        titleNode.fontName = "Arial-Bold"
        titleNode.xScale=CGFloat(screenWidth/1.6)/titleNode.frame.width
        titleNode.yScale=titleNode.xScale
        titleNode.position=CGPoint(x: screenWidth/2, y: screenHeight/1.5)
        
        
        startButton = SKSpriteNode(imageNamed:"ButtonStart")
        startButton.xScale = (CGFloat(screenWidth/6.5))/startButton.frame.width
        startButton.yScale=startButton.xScale
        //startButton.yScale = (CGFloat(screenWidth/6.5))/startButton.frame.width
        startButton.name="Start Button"
        startButton.zPosition = 1
        startButton.position = CGPoint(x:screenWidth*0.415, y:screenHeight*0.555)
        
        leaderboardButton = SKSpriteNode(imageNamed:"Leaderboard")
        leaderboardButton.xScale = (CGFloat(screenWidth/6.5))/leaderboardButton.frame.width
        leaderboardButton.yScale=startButton.xScale
        //startButton.yScale = (CGFloat(screenWidth/6.5))/startButton.frame.width
        leaderboardButton.name="Start Button"
        leaderboardButton.zPosition = 1
        leaderboardButton.position = CGPoint(x:highScoreLabel.position.x-highScoreLabel.frame.width/2-leaderboardButton.frame.width/2-10, y:highScoreLabel.position.y)
        leaderboardButton.name="unpushed"
        
        rateButton = SKSpriteNode(imageNamed:"Settings")
        rateButton.xScale = (CGFloat(screenWidth/6.5))/rateButton.frame.width
        rateButton.yScale=startButton.xScale
        //startButton.yScale = (CGFloat(screenWidth/6.5))/startButton.frame.width
        rateButton.name="Start Button"
        rateButton.zPosition = 1
        rateButton.position = CGPoint(x:screenWidth*0.415, y:screenHeight*0.2)
        rateButton.name="unpushed"
        
        
        hardButton = SKSpriteNode(imageNamed:"HardButton")
        hardButton.xScale = (CGFloat(screenWidth/6.5))/hardButton.frame.width
        hardButton.yScale=hardButton.xScale
        //startButton.yScale = (CGFloat(screenWidth/6.5))/startButton.frame.width
        hardButton.name="Hard Button"
        hardButton.zPosition = 1
        hardButton.position = CGPoint(x:screenWidth*0.585, y:screenHeight*0.445)
        hardButton.name="unpushed"

        startButtonPushed = SKSpriteNode(imageNamed:"ButtonStartPushed")
        startButtonPushed.xScale = (CGFloat(screenWidth/6.5))/startButtonPushed.frame.width
        startButtonPushed.yScale=startButton.xScale
        ///startButtonPushed.yScale = (CGFloat(screenWidth/6.5))/startButtonPushed.frame.width
        startButtonPushed.name="Start Button Pushed"
        startButtonPushed.zPosition = 1
        startButtonPushed.position = CGPoint(x:screenWidth*0.415, y:screenHeight*0.555)
        
        multiButton = SKSpriteNode(imageNamed:"Multiplayer")
        multiButton.xScale = (CGFloat(screenWidth/6.5))/multiButton.frame.width
        multiButton.yScale=multiButton.xScale
        //startButton.yScale = (CGFloat(screenWidth/6.5))/startButton.frame.width
        multiButton.name="Multiplayer Button"
        multiButton.zPosition = 1
        multiButton.position = CGPoint(x:screenWidth*0.415, y:screenHeight*0.445)
        //println(String(stringInterpolationSegment: multiButton.frame.width) + " " + String(stringInterpolationSegment: startButton.frame.width))
        multiButtonPushed = SKSpriteNode(imageNamed:"MultiplayerPushed")
        multiButtonPushed.xScale = (CGFloat(screenWidth/6.5))/multiButtonPushed.frame.width
        multiButtonPushed.yScale=multiButtonPushed.xScale
        ///artButtonPushed.yScale = (CGFloat(screenWidth/6.5))/startButtonPushed.frame.width
        multiButtonPushed.name="Multiplayer Button Pushed"
        multiButtonPushed.zPosition = 1
        multiButtonPushed.position = CGPoint(x:screenWidth*0.415, y:screenHeight*0.445)
        
        aboutButton = SKSpriteNode(imageNamed:"AboutButton")
        aboutButton.xScale = (CGFloat(screenWidth/6.5))/aboutButton.frame.width
        aboutButton.yScale=aboutButton.xScale
        //startButton.yScale = (CGFloat(screenWidth/6.5))/startButton.frame.width
        aboutButton.name="Multiplayer Button"
        aboutButton.zPosition = 1
        aboutButton.position = CGPoint(x:screenWidth*0.585, y:screenHeight*0.2)
        
        aboutButtonPushed = SKSpriteNode(imageNamed:"AboutButtonPushed")
        aboutButtonPushed.xScale = (CGFloat(screenWidth/6.5))/aboutButtonPushed.frame.width
        aboutButtonPushed.yScale=aboutButtonPushed.xScale
        ///atButtonPushed.yScale = (CGFloat(screenWidth/6.5))/startButtonPushed.frame.width
        aboutButtonPushed.name="Multiplayer Button Pushed"
        aboutButtonPushed.zPosition = 1
        aboutButtonPushed.position = CGPoint(x:screenWidth*0.585, y:screenHeight*0.2)
        
        paddleButton = SKSpriteNode(imageNamed:"PaddlesButton")
        paddleButton.xScale = (CGFloat(screenWidth/6.5))/paddleButton.frame.width
        paddleButton.yScale=paddleButton.xScale
        //startButton.yScale = (CGFloat(screenWidth/6.5))/startButton.frame.width
        paddleButton.name="Start Button"
        paddleButton.zPosition = 1
        paddleButton.position = CGPoint(x:screenWidth*0.585, y:screenHeight*0.555)
        
        paddleButtonPushed = SKSpriteNode(imageNamed:"PaddlesButtonPushed")
        paddleButtonPushed.xScale = (CGFloat(screenWidth/6.5))/paddleButtonPushed.frame.width
        paddleButtonPushed.yScale=paddleButtonPushed.xScale
        ///startButtonPushed.yScale = (CGFloat(screenWidth/6.5))/startButtonPushed.frame.width
        paddleButtonPushed.name="Start Button Pushed"
        paddleButtonPushed.zPosition = 1
        paddleButtonPushed.position = CGPoint(x:screenWidth*0.585, y:screenHeight*0.555)
        
        
        note1.fontSize = 17
        note1.fontName = "Arial-Bold"
        note1.position=CGPoint(x: screenWidth/2, y: screenHeight*0.28)
        
        note2.fontSize = 17
        note2.fontName = "Arial-Bold"
        note2.position=CGPoint(x: screenWidth/2, y: Double(note1.position.y-20))

        self.addChild(startButton)
        self.addChild(paddleButton)
        self.addChild(titleNode)
        self.addChild(gemsNode)
        self.addChild(gemSprite)
        self.addChild(highScoreLabel)
        self.addChild(multiButton)
        self.addChild(aboutButton)
        self.addChild(leaderboardButton)
        self.addChild(hardButton)
        self.addChild(hardHighScoreLabel)
//        self.addChild(note1)
  //      self.addChild(note2)
        self.addChild(rateButton)
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
        /*if let vc = self.view?.window?.rootViewController as? UIViewController{
            print("worked")
            
            
        }
        else{
            print("no....")
        }*/
        
        
        print(scene?.size.width)
        print(view.bounds.size.width)
        print(scene!.view!.bounds.size.width)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(scene!.size.width)
        for touch in (touches ) {
            let location = touch.location(in: self)
            
            if(startButton.contains(location)){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                startButton.removeFromParent()
                self.addChild(startButtonPushed)
                
            }
            if(leaderboardButton.contains(location) && leaderboardButton.name=="unpushed"){
                leaderboardButton.name="pushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                leaderboardButton.texture = SKTexture(imageNamed: "LeaderboardPushed")
                
            }
            if(rateButton.contains(location)&&rateButton.name=="unpushed"){
                rateButton.name="pushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                rateButton.texture = SKTexture(imageNamed: "SettingsPushed")
                
            }
            if(hardButton.contains(location)&&hardButton.name=="unpushed"){
                hardButton.name="pushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                hardButton.texture = SKTexture(imageNamed: "HardButtonPushed")
                
            }
            if(paddleButton.contains(location)){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                paddleButton.removeFromParent()
                self.addChild(paddleButtonPushed)
            }
            if(multiButton.contains(location)){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                multiButton.removeFromParent()
                self.addChild(multiButtonPushed)
            }
            if(aboutButton.contains(location)){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                aboutButton.removeFromParent()
                self.addChild(aboutButtonPushed)
            }
        }
    }
    
    override func touchesMoved(_ touches:  Set<UITouch>, with event: UIEvent?) {
        
        for touch:AnyObject in touches {
            let location = touch.location(in: self)
            /*if(!startButtonPushed.containsPoint(location)&&startButtonPushed.parent==self){
                startButtonPushed.removeFromParent()
                self.addChild(startButton)
            }*/
            if(startButton.contains(location)&&startButtonPushed.parent != self){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                startButton.removeFromParent()
                self.addChild(startButtonPushed)
            }
            if(leaderboardButton.contains(location)&&leaderboardButton.name=="unpushed"){
                leaderboardButton.name="pushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                leaderboardButton.texture = SKTexture(imageNamed: "LeaderboardPushed")
            }
            if(rateButton.contains(location)&&rateButton.name=="unpushed"){
                rateButton.name="pushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                rateButton.texture = SKTexture(imageNamed: "SettingsPushed")
            }
            if(hardButton.contains(location)&&hardButton.name=="unpushed"){
                hardButton.name="pushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                hardButton.texture = SKTexture(imageNamed: "HardButtonPushed")
                
            }
            if(paddleButton.contains(location)&&paddleButtonPushed.parent != self){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                paddleButton.removeFromParent()
                self.addChild(paddleButtonPushed)
            }
            if(multiButton.contains(location)&&multiButtonPushed.parent != self){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                multiButton.removeFromParent()
                self.addChild(multiButtonPushed)
            }
            if(aboutButton.contains(location)&&aboutButtonPushed.parent != self){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                aboutButton.removeFromParent()
                self.addChild(aboutButtonPushed)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches ) {
        let location = touch.location(in: self)
        
            
            if(leaderboardButton.contains(location)){
                leaderboardButton.name="unpushed"
                //println("in")
                leaderboardButton.texture = SKTexture(imageNamed: "Leaderboard")
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                if(GKLocalPlayer.localPlayer().isAuthenticated){
                    showLeaderboard()
                }
                else{
                    let alert = UIAlertController(title: "Game Center not Authenticated", message: "You are either not signed into Game Center, or you have not waited for the welcome banner to show", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.view?.window?.rootViewController?.present(alert, animated: false, completion: nil)
                }
                
            }
            else if(leaderboardButton.name=="pushed"){
                leaderboardButton.name="unpushed"
                leaderboardButton.texture = SKTexture(imageNamed: "Leaderboard")
                //runAction(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
            }
            if(rateButton.contains(location)){
                //println("in")
                
                rateButton.texture = SKTexture(imageNamed: "Settings")
                rateButton.name="unpushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                
                let transition = SKTransition.fade(withDuration: 0.5)
                print("size="+scene!.size.width.description)
                let nextScene = SettingsScene(size: scene!.size)
                print(nextScene.size.width)
                nextScene.scaleMode = .aspectFit
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                scene?.view?.presentScene(nextScene, transition: transition)
            }
            else if(rateButton.name=="pushed"){
                rateButton.texture = SKTexture(imageNamed: "Settings")
                rateButton.name="unpushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
            }
            if(hardButton.contains(location)){
                //println("in")
                
                hardButton.texture = SKTexture(imageNamed: "HardButton")
                hardButton.name="unpushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                
                let transition = SKTransition.fade(withDuration: 0.5)
                
                let nextScene = HardScene(size: scene!.size)
                nextScene.scaleMode = .aspectFill
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                scene?.view?.presentScene(nextScene, transition: transition)
            }
            else if(hardButton.name=="pushed"){
                hardButton.texture = SKTexture(imageNamed: "HardButton")
                hardButton.name="unpushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
            }
            if(startButtonPushed.contains(location)){
                //println("in")
                startButtonPushed.removeFromParent()
                self.addChild(startButton)
                
                let transition = SKTransition.fade(withDuration: 0.5)
            
                let nextScene = GameScene(size: scene!.size)
                nextScene.scaleMode = .aspectFill
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                scene?.view?.presentScene(nextScene, transition: transition)
            }
            else if(startButtonPushed.parent==self){
                startButtonPushed.removeFromParent()
                if(startButton.parent != self){
                self.addChild(startButton)
                }
            }
            if(paddleButtonPushed.contains(location)){
                //println("in")
                paddleButtonPushed.removeFromParent()
                self.addChild(paddleButton)
                let transition = SKTransition.fade(withDuration: 0.5)
                
                let nextScene = PaddleScene(size: scene!.size)
                nextScene.scaleMode = .aspectFill
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                scene?.view?.presentScene(nextScene, transition: transition)
            }
            else if(paddleButtonPushed.parent==self){
                paddleButtonPushed.removeFromParent()
                if(paddleButton.parent != self){
                self.addChild(paddleButton)
                }
            }
            
            if(multiButtonPushed.contains(location)){
                //println("in")
                multiButtonPushed.removeFromParent()
                self.addChild(multiButton)
                let transition = SKTransition.fade(withDuration: 0.5)
                
                let nextScene = MultiplayerScene(size: scene!.size)
                nextScene.scaleMode = .aspectFill
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                scene?.view?.presentScene(nextScene, transition: transition)
            }
            else if(multiButtonPushed.parent==self){
                multiButtonPushed.removeFromParent()
                if(multiButton.parent != self){
                self.addChild(multiButton)
                }
            }
            if(aboutButtonPushed.contains(location)){
                //println("in")
                aboutButtonPushed.removeFromParent()
                self.addChild(aboutButton)
                let transition = SKTransition.fade(withDuration: 0.5)
                
                let nextScene = AboutScene(size: scene!.size)
                nextScene.scaleMode = .aspectFill
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                scene?.view?.presentScene(nextScene, transition: transition)
            }
            else if(aboutButtonPushed.parent==self){
                aboutButtonPushed.removeFromParent()
                if(aboutButton.parent != self){
                    self.addChild(aboutButton)
                }
            }
        }
    }
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
      
        
    }
    func showLeaderboard(){
        let gcViewController: GKGameCenterViewController = GKGameCenterViewController()
        gcViewController.gameCenterDelegate = self
        
        gcViewController.viewState = GKGameCenterViewControllerState.leaderboards
        gcViewController.leaderboardIdentifier = "grp.curveballhighscore"
        
        self.view!.window?.rootViewController!.present(gcViewController, animated: true, completion: nil)
    }
}



