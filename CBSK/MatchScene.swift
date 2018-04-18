//
//  MatchScene.swift
//  Curveball
//
//  Created by Jamal Hashim on 12/22/15.
//  Copyright (c) 2015 Jamal Hashim. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit

class MatchScene: SKScene, GKMatchDelegate {
    var looking:Bool = false;
    var game:Bool = false
    var randNum:Bool = false
    var randReceived:Bool = false
    var server:Bool = false;
    var gameStarted:Bool = false
    var myNum:Int = 0
    let statusLabel = SKLabelNode(fontNamed:"Chalkduster")
    var match:GKMatch!
    var screenWidth:Double=0
    var screenHeight:Double=0
    var zoom:Double=0
    var menuButton:SKSpriteNode = SKSpriteNode()
    var menuButtonPushed:SKSpriteNode = SKSpriteNode()
    var ballEdge:Bool = false
    var response:Int = 0
    var red:Bool = false
    var hostServe = false
    var gameOver = false
    let titleNode = SKLabelNode(text: "Multiplayer")
    let GemsLabel = SKLabelNode(text: "+10")
    let gemSprite = SKSpriteNode(imageNamed: "GemOpaque")
    var retryButton:SKSpriteNode = SKSpriteNode()
    var retryButtonPushed:SKSpriteNode = SKSpriteNode()
    var oppCurveX:Double = 0
    var oppCurveY:Double = 0
    
    var lastUpdateTimeInterval: CFTimeInterval = 0
    var paddletouched=false
    var paddle:SKSpriteNode=SKSpriteNode();
    var paddleOpp:SKSpriteNode=SKSpriteNode();
    let vecb1:Vector=Vector(x: -3, y: -2, z: 8)
    let vecb2:Vector=Vector(x: 3, y: 2, z: 8)
    let playerPaddle:Paddle = variables.paddle
    let oppPaddle:Paddle = OppPaddle(z: 24)
    let ball = Ball(x:-0.25,y:-0.25,z:8);
    var ballNode:SKSpriteNode = SKSpriteNode()
    var ballRect:Rect3D = Rect3D(x: -3, y: -2, z: 8, width: 6, height: 4, back: 0)
    var inPlay=true
    var ballRectNode:SKShapeNode = SKShapeNode()
    var ballSpeed:Double = 11
    var level:Double = 10
    var playerLivesLabel = SKLabelNode()
    var oppLivesLabel = SKLabelNode()
    var scoreLabel = SKLabelNode()
    var earnedLabel = SKLabelNode()
    var playerLives = 5
    var oppLives = 5
    var levelLabel = SKLabelNode()
    var pause:Bool = false
    let pauseNode = SKSpriteNode(imageNamed: "PauseButton")
    let pausePushedNode = SKSpriteNode(imageNamed: "PauseButtonPushed")
    var translucentRectNode = SKShapeNode()
    let resumeButtonNode = SKSpriteNode(imageNamed: "ResumeButton")
    let resumeButtonPushedNode = SKSpriteNode(imageNamed: "ResumeButtonPushed")
    let menuButtonNode = SKSpriteNode(imageNamed: "MenuButton")
    let menuButtonPushedNode = SKSpriteNode(imageNamed: "MenuButtonPushed")
    var score = 0;
    var toBeEarned = 3000;
    override func didMove(to view: SKView) {
        let number: Int = Int(arc4random_uniform(2000000))
        myNum=number
        // sleep(10)
        /* Setup your scene here */

        self.scaleMode = SKSceneScaleMode.resizeFill
        
        //levelLabel.text=("Level: "+String(Int(level)))
        
        variables.background=false
        
        
        self.backgroundColor=SKColor.black
        screenWidth=Double(view.bounds.size.width)
        screenHeight = Double(view.bounds.size.height)
        zoom = Double(view.bounds.size.width)*1.05
        statusLabel.text = "Not Authenticated";
        statusLabel.fontSize = 25;
        statusLabel.position = CGPoint(x:view.bounds.size.width/2, y:view.bounds.size.height/2);
        self.addChild(statusLabel)
        
        titleNode.fontSize = 100
        titleNode.fontName = "Arial-Bold"
        titleNode.xScale=CGFloat(screenWidth/1.6)/titleNode.frame.width
        titleNode.yScale=titleNode.xScale
        titleNode.position=CGPoint(x: screenWidth/2, y: screenHeight/1.4)
        
        
        levelLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        levelLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        levelLabel.position = CGPoint(x: Double(screenWidth/2), y: Double(screenHeight-10))
        levelLabel.fontSize=20
        levelLabel.fontName="Arial-Bold"

        
        
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
        
        
        retryButton = SKSpriteNode(imageNamed:"PlayAgainButton")
        retryButton.xScale = (CGFloat(screenWidth/6.5))/retryButton.frame.width
        retryButton.yScale=retryButton.xScale
        retryButton.name="Retry Button"
        retryButton.zPosition = 1
        retryButton.position = CGPoint(x:screenWidth/2, y:screenHeight/2)
        
        retryButtonPushed = SKSpriteNode(imageNamed:"PlayAgainButtonPushed")
        retryButtonPushed.xScale = (CGFloat(screenWidth/6.5))/retryButtonPushed.frame.width
        retryButtonPushed.yScale=retryButtonPushed.xScale
        retryButtonPushed.name="Retry Button Pushed"
        retryButtonPushed.zPosition = 1
        retryButtonPushed.position = CGPoint(x:screenWidth/2, y:screenHeight/2)
        
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
        self.addChild(menuButton)
        
        
        playerLivesLabel.text=("Your lives: "+String(playerLives))
        
        playerLivesLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        playerLivesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        playerLivesLabel.position = CGPoint(x: screenWidth-20, y: screenHeight*0.87)
        playerLivesLabel.fontSize=15
        playerLivesLabel.fontName="Arial-Bold"
    
        
        oppLivesLabel.text=("Opponent lives: "+String(oppLives))
        
        oppLivesLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        oppLivesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        oppLivesLabel.position = CGPoint(x: 20, y: screenHeight*0.87)
        oppLivesLabel.fontSize=15
        oppLivesLabel.fontName="Arial-Bold"
        
        
        let localPlayer = GKLocalPlayer.localPlayer()
        
        if(!looking&&localPlayer.isAuthenticated && !game){
            looking = true
            statusLabel.text = "matching"
            //println(localPlayer.authenticated)
            
            let req = GKMatchRequest()
            req.maxPlayers=2
            req.minPlayers=2
            let f = GKMatchmaker()
            f.findMatch(for: req, withCompletionHandler: {(match : GKMatch?, error: Error?
                ) -> Void in
                // println(error.description)
                if((match) != nil){
                match!.delegate = self
                self.match = match
                self.statusLabel.text="starting"
                self.game = true
                self.looking = false;
                //println("found")
                }
                else{
                   // println("error")
                    if(error != nil){
                        self.statusLabel.text = "Error. Please try again"
                       // println(error?.description)
                    }
                }
                
            } as! (GKMatch?, Error?) -> Void)
        }

        
        
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
            if(retryButton.contains(location)&&retryButton.parent==self){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                retryButton.removeFromParent()
                self.addChild(retryButtonPushed)
            }
        }
        
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch:AnyObject in touches {
        let location = touch.location(in: self)
        if(paddletouched==true){
            let location = touch.location(in: self)
            paddle.position = CGPoint(x: location.x, y: location.y)
            
        }
        
               
        let touchedNode = atPoint(location)
        if(paddle.contains(location)){
            paddletouched=true
            paddle.position = CGPoint(x: location.x, y: location.y)
        }
            
        if(menuButton.contains(location)&&menuButtonPushed.parent != self){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                menuButton.removeFromParent()
                self.addChild(menuButtonPushed)
        }
            if(retryButton.contains(location)&&retryButtonPushed.parent != self&&retryButton.parent==self){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                retryButton.removeFromParent()
                self.addChild(retryButtonPushed)
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        paddletouched=false
        for touch in (touches ) {
            let location = touch.location(in: self)
            
            if(menuButtonPushed.contains(location)){
                variables.background = true
                if(match != nil){
                match.disconnect()
                }
                menuButtonPushed.removeFromParent()
                variables.background = true
                // println("in")
                
                self.addChild(menuButton)
               if(gameOver||match==nil || (!gameStarted)){
                let transition = SKTransition.fade(withDuration: 0.5)
                
                let nextScene = MultiplayerScene(size: scene!.size)
                nextScene.scaleMode = .aspectFill
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                    scene?.view?.presentScene(nextScene, transition: transition)
               }
            }
            else if(menuButtonPushed.parent==self){
                menuButtonPushed.removeFromParent()
                if(menuButton.parent != self){
                self.addChild(menuButton)
                }
            }
            if(retryButtonPushed.contains(location)&&retryButtonPushed.parent==self){
                match.disconnect()
                retryButtonPushed.removeFromParent()
                self.addChild(retryButton)
                //println("in")
                let transition = SKTransition.fade(withDuration: 0.5)
                
                let nextScene = MatchScene(size: scene!.size)
                nextScene.scaleMode = .aspectFill
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                scene?.view?.presentScene(nextScene, transition: transition)
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
        if(gameOver){
            if(!variables.background&&match != nil){
                let gameData = MatchData(padx: Float((playerPaddle.vec3.x+playerPaddle.vec1.x)/2), pady: Float((playerPaddle.vec3.y+playerPaddle.vec1.y)/2), gameOver: false, ballx: Float(ball.vec1.x), bally: Float(ball.vec1.y), ballz: Float(ball.vec1.z),ballEdge: ballEdge,response:0,red:red,ballSpeed:ballSpeed,ballCurveX:ball.curveX,ballCurveY:ball.curveY,hostLives:playerLives,clientLives:oppLives,ballxSpeed:ball.xSpeed,ballySpeed:ball.ySpeed,padCurveX:playerPaddle.getCurveX(),padCurveY:playerPaddle.getCurveY())
                let data = NSKeyedArchiver.archivedData(withRootObject: gameData)
                do {
                    try self.match.sendData(toAllPlayers: data, with:GKMatchSendDataMode.unreliable)
                } catch {
                    ///NSErrorPointer().memory = error
                }
            }
            return;
        }
        if(variables.background == true){
            if(match != nil){
            match.disconnect()
            }
            
        }
        if(game && self.match.expectedPlayerCount==0 && randNum==false){
           // println("sent")
            randNum=true
            statusLabel.removeFromParent()
            //self.statusLabel.text="Started"
            //let data = Data(buffer: UnsafeBufferPointer(start: myNum, count: 1))
            let data = Foundation.Data(buffer: UnsafeBufferPointer(start: &myNum, count: 1))
            //let data = Foundation.Data(bytes: UnsafePointer<UInt8>(&myNum), count: sizeof(Int))
            do {
                try match.sendData(toAllPlayers: data , with: GKMatchSendDataMode.reliable)
            } catch {
                //NSErrorPointer().memory = error
            }
            
        
        }
        if(gameStarted&&server){
            if Double(paddle.position.x-paddle.frame.width/2) <= vecb1.convertToX(Double(screenWidth), zoom: zoom){
                paddle.position.x=CGFloat(vecb1.convertToX(Double(screenWidth), zoom: zoom))+paddle.frame.width/2
            }
            if Double(paddle.position.x+paddle.frame.width/2) >= vecb2.convertToX(Double(screenWidth), zoom: zoom){
                paddle.position.x=CGFloat(vecb2.convertToX(Double(screenWidth), zoom: zoom))-paddle.frame.width/2
            }
            
            if Double(paddle.position.y-paddle.frame.height/2) <= vecb1.convertToY(Double(screenHeight), zoom: zoom){
                paddle.position.y=CGFloat(vecb1.convertToY(Double(screenHeight), zoom: zoom))+paddle.frame.height/2
            }
            if Double(paddle.position.y+paddle.frame.height/2) >= vecb2.convertToY(Double(screenHeight), zoom: zoom){
                paddle.position.y=CGFloat(vecb2.convertToY(Double(screenHeight), zoom: zoom))-paddle.frame.height/2
            }
            
            playerPaddle.setLoc(paddle, screenx: Double(screenWidth), screeny: Double(screenHeight), zoom: zoom)
            //  playerPaddle.printVectors()
            
            playerPaddle.addPoint()
           // println(red)
            let gameData = MatchData(padx: Float((playerPaddle.vec3.x+playerPaddle.vec1.x)/2), pady: Float((playerPaddle.vec3.y+playerPaddle.vec1.y)/2), gameOver: false, ballx: Float(ball.vec1.x), bally: Float(ball.vec1.y), ballz: Float(ball.vec1.z),ballEdge: ballEdge,response:0,red:red,ballSpeed:ballSpeed,ballCurveX:ball.curveX,ballCurveY:ball.curveY,hostLives:playerLives,clientLives:oppLives,ballxSpeed:ball.xSpeed,ballySpeed:ball.ySpeed,padCurveX:0,padCurveY:0)
            let data = NSKeyedArchiver.archivedData(withRootObject: gameData)
            do {
                try self.match.sendData(toAllPlayers: data, with:GKMatchSendDataMode.unreliable)
            } catch {
               // NSErrorPointer().memory = error
            }
            
            
            paddleOpp.removeFromParent()
            paddleOpp = oppPaddle.paddleNode(Double(screenWidth), screeny: Double(screenHeight), zoom: zoom, color: 1)
            self.addChild(paddleOpp)
           
            
            
            
            var delta: CFTimeInterval = currentTime - lastUpdateTimeInterval
            
            if(ballEdge){
                if(response != 0){
                    ballEdge=false
                    if(response==2){
                        ballRectNode.removeFromParent()
                        ballNode.removeFromParent()
                        ballNode = ball.ballNode(Double(screenWidth), screeny: Double(screenHeight), zoom: zoom)
                        red = false
                        self.addChild(ballNode)
                        inPlay=false
                        oppLives -= 1
                        red = true;
                        oppLivesLabel.text=("Opponent lives: "+String(oppLives))
                        ballSpeed=12
                        if(oppLives==0){
                            gameOver = true;
                            self.removeAllChildren()
                            levelLabel.text = "You Won!"
                            self.addChild(levelLabel)
                            variables.gems+=10
                            menuButton.texture = SKTexture(imageNamed: "ExitButton")
                            menuButtonPushed.texture = SKTexture(imageNamed: "ExitButtonPushed")
                            self.addChild(menuButton)
                            self.addChild(GemsLabel)
                            self.addChild(gemSprite)
                            self.addChild(retryButton)
                        }
                    }
                    else{
                        if(ballSpeed<21){
                        ballSpeed+=1
                        }
                        ball.zSpeed = -ballSpeed * oppPaddle.power
                        //ball.curveX=0
                        //ball.curveY=0
                        /*ball.curveX=oppPaddle.getCurveX()*(ballSpeed/18)
                        ball.curveY=oppPaddle.getCurveY()*(ballSpeed/18)*/
                        
                        ball.curveX=oppCurveX*(ballSpeed/18)
                        ball.curveY=oppCurveY*(ballSpeed/18)
                        
                        var divisorX = oppPaddle.getCurveX()/4.2
                        var divisorY = oppPaddle.getCurveY()/4.2
                        if(divisorX<1){
                            divisorX=1
                        }
                        if(divisorY<1){
                            divisorY=1
                        }
                        ball.xSpeed = ball.xSpeed/divisorX
                        ball.ySpeed = ball.ySpeed/divisorY
                        ball.setZ(ball.vec1.z-0.05)
                    }
                    response=0
                }
                else{
                    return;
                }
            }
            
            if(inPlay==false){
                ballSpeed=12
                
                red = true;
                if(delta<2){
                    
                    //ballNode.removeFromParent()
                    //ballNode.strokeColor=SKColor.redColor()
                    //ballNode.fillColor=SKColor.redColor()
                    ballNode.texture = SKTexture(imageNamed: "Ball2")
                    red = true
                    // self.addChild(ballNode)
                    return;
                }
                else{
                    if(oppLives==0){
                        gameOver = true;
                        self.removeAllChildren()
                        levelLabel.text = "You Won!"
                        self.addChild(levelLabel)
                        variables.gems+=10
                        menuButton.texture = SKTexture(imageNamed: "ExitButton")
                        menuButtonPushed.texture = SKTexture(imageNamed: "ExitButtonPushed")
                        self.addChild(menuButton)
                        self.addChild(GemsLabel)
                        self.addChild(gemSprite)
                        self.addChild(retryButton)
                    }
                }
                    
                inPlay=true
                ballSpeed=12
                if(hostServe){
                    ball.zSpeed = -ballSpeed
                    ball.setZ((23))
                    hostServe = false
                }
                else{
                    ball.zSpeed = ballSpeed
                    ball.setZ((9))
                    hostServe=true
                }
                    ball.setX((-0.25))
                    ball.setY((-0.25))
                    ball.xSpeed=0
                    ball.ySpeed=0
                    ball.curveX=0
                    ball.curveY=0
                    delta=0
                }
                
                
            
            
            lastUpdateTimeInterval = currentTime
            
            if(delta>1){
                return
            }
            
            
            
            
           
           // oppPaddle.addPoint()
           
            
            //ballNode.removeFromParent()
            ball.updateBall(delta)
            red = false
            if(ball.vec1.z<=8){
                
                if(ball.vec1.x>playerPaddle.vec3.x||ball.vec3.x<playerPaddle.vec1.x||ball.vec1.y>playerPaddle.vec3.y||ball.vec3.y<playerPaddle.vec1.y){
                    inPlay=false
                    ballNode.removeFromParent()
                    ballNode = ball.ballNode(Double(screenWidth), screeny: Double(screenHeight), zoom: zoom)
                    ballRectNode.removeFromParent()
                    ballRect.setZ(ball.vec3.z)

                   // ballRectNode=ballRect.rectNodeXY(screenWidth, screeny: screenHeight, zoom: zoom, color: SKColor.blueColor())
//                    self.addChild(ballRectNode)
                    self.addChild(ballNode)
                    playerLives -= 1
                    playerLivesLabel.text=("Your lives: "+String(playerLives))
                   
                    if(playerLives==0){
                        gameOver = true;
                        self.removeAllChildren()
                        levelLabel.text = "You Lost"
                        self.addChild(levelLabel)
                        menuButton.texture = SKTexture(imageNamed: "ExitButton")
                        menuButtonPushed.texture = SKTexture(imageNamed: "ExitButtonPushed")
                        self.addChild(menuButton)
                        self.addChild(retryButton)
                        
                    }
                    return;
                }
                if(ballSpeed<21){
                    ballSpeed+=1
                }
                run(SKAction.playSoundFileNamed("Ball.mp3", waitForCompletion: false))
                ball.curveX=playerPaddle.getCurveX()*(ballSpeed/18)
                ball.curveY=playerPaddle.getCurveY()*(ballSpeed/18)
                //println(playerPaddle.getCurveX())
                var divisorX = playerPaddle.getCurveX()/4.2
                var divisorY = playerPaddle.getCurveY()/4.2
                if(divisorX<1){
                    divisorX=1
                }
                if(divisorY<1){
                    divisorY=1
                }
                ball.xSpeed = ball.xSpeed/divisorX
                ball.ySpeed = ball.ySpeed/divisorY
                
                ball.zSpeed = ballSpeed*1
                ball.setZ(ball.vec1.z+0.05)
            }
            
            if(ball.vec1.z>=24){
                ballEdge=true
                return;
                if(ball.vec1.x>oppPaddle.vec3.x||ball.vec3.x<oppPaddle.vec1.x||ball.vec1.y>oppPaddle.vec3.y||ball.vec3.y<oppPaddle.vec1.y){
                    /*ballRectNode.removeFromParent()
                    ballNode = ball.ballNode(Double(screenWidth), screeny: Double(screenHeight), zoom: zoom)
                
                    self.addChild(ballNode)
                    inPlay=false
                    oppLives--
                   // oppLivesLabel.text=("Opponent lives: "+String(oppLives))
                    return;*/
                }
                run(SKAction.playSoundFileNamed("Ball.mp3", waitForCompletion: false))
                ball.zSpeed = -ballSpeed * oppPaddle.power
                //ball.curveX=0
                //ball.curveY=0
                ball.curveX=oppPaddle.getCurveX()
                ball.curveY=oppPaddle.getCurveY()
                var divisorX = oppPaddle.getCurveX()/4.2
                var divisorY = oppPaddle.getCurveY()/4.2
                if(divisorX<1){
                    divisorX=1
                }
                if(divisorY<1){
                    divisorY=1
                }
                ball.xSpeed = ball.xSpeed/divisorX
                ball.ySpeed = ball.ySpeed/divisorY
                ball.setZ(ball.vec1.z-0.05)
            }
            
            if(ball.vec1.x<=(-3)){
                ball.xSpeed = -ball.xSpeed
            }
            if(ball.vec3.x>=(3)){
                ball.xSpeed = -ball.xSpeed
            }
            
            if(ball.vec1.y<=(-2)){
                ball.ySpeed = -ball.ySpeed
            }
            if(ball.vec3.y>=(2)){
                ball.ySpeed = -ball.ySpeed
            }
            
            ballNode.removeFromParent()
            ballRectNode.removeFromParent()
            ballNode = ball.ballNode(Double(screenWidth), screeny: Double(screenHeight), zoom: zoom)
            red = false
            ballRect.setZ(ball.vec3.z)
            ballRectNode=ballRect.rectNodeXY(Double(screenWidth), screeny: Double(screenHeight), zoom: zoom, color: SKColor.blue)
            ballRectNode.zPosition = -1
            self.addChild(ballRectNode)
            self.addChild(ballNode)
        }
        else if(gameStarted){
            if Double(paddle.position.x-paddle.frame.width/2) <= vecb1.convertToX(Double(screenWidth), zoom: zoom){
                paddle.position.x=CGFloat(vecb1.convertToX(Double(screenWidth), zoom: zoom))+paddle.frame.width/2
            }
            if Double(paddle.position.x+paddle.frame.width/2) >= vecb2.convertToX(Double(screenWidth), zoom: zoom){
                paddle.position.x=CGFloat(vecb2.convertToX(Double(screenWidth), zoom: zoom))-paddle.frame.width/2
            }
            
            if Double(paddle.position.y-paddle.frame.height/2) <= vecb1.convertToY(Double(screenHeight), zoom: zoom){
                paddle.position.y=CGFloat(vecb1.convertToY(Double(screenHeight), zoom: zoom))+paddle.frame.height/2
            }
            if Double(paddle.position.y+paddle.frame.height/2) >= vecb2.convertToY(Double(screenHeight), zoom: zoom){
                paddle.position.y=CGFloat(vecb2.convertToY(Double(screenHeight), zoom: zoom))-paddle.frame.height/2
            }
            
            playerPaddle.setLoc(paddle, screenx: Double(screenWidth), screeny: Double(screenHeight), zoom: zoom)
            playerPaddle.addPoint()
            //  playerPaddle.printVectors()
            let delta: CFTimeInterval = currentTime - lastUpdateTimeInterval
            lastUpdateTimeInterval = currentTime
            //println(red)
            if(red){
                ballNode.removeFromParent()
                ballNode.texture = SKTexture(imageNamed: "Ball2")
                self.addChild(ballNode)
                let ballNode2 = SKSpriteNode(imageNamed: "Ball2")
                ballNode2.position = ballNode.position
                ballNode2.xScale = ballNode.xScale
                ballNode2.yScale=ballNode.yScale
               
                ballNode.removeFromParent()
                ballNode=ballNode2
                self.addChild(ballNode)
                return;
            }
            
            else{
              //  println("nope")
            }
            //println(ballNode.texture?.description)
            if(ballEdge){
                return;
            }
            if(delta>1){
                return;
            }
            
            let gameData = MatchData(padx: Float((playerPaddle.vec3.x+playerPaddle.vec1.x)/2), pady: Float((playerPaddle.vec3.y+playerPaddle.vec1.y)/2), gameOver: false, ballx: 0, bally: 0, ballz: 0,ballEdge:false,response:0,red:false,ballSpeed:0,ballCurveX:0,ballCurveY:0,hostLives:0,clientLives:0,ballxSpeed:0,ballySpeed:0,padCurveX:playerPaddle.getCurveX(),padCurveY:playerPaddle.getCurveY())
            let data = NSKeyedArchiver.archivedData(withRootObject: gameData)
            do {
                try self.match.sendData(toAllPlayers: data, with:GKMatchSendDataMode.unreliable)
            } catch {
                //NSErrorPointer().memory = error
            }
            paddleOpp.removeFromParent()
            paddleOpp = oppPaddle.paddleNode(Double(screenWidth), screeny: Double(screenHeight), zoom: zoom, color: 1)
            self.addChild(paddleOpp)
            ballNode.removeFromParent()
            ball.zSpeed=ballSpeed
            ball.updateBall(delta)
            ballNode = ball.ballNode(Double(screenWidth), screeny: Double(screenHeight), zoom: zoom)
            self.addChild(ballNode)
            ballRectNode.removeFromParent()
            ballRect.setZ(ball.vec3.z)
            ballRectNode=ballRect.rectNodeXY(Double(screenWidth), screeny: Double(screenHeight), zoom: zoom, color: SKColor.blue)
            ballRectNode.zPosition = -1
            self.addChild(ballRectNode)
        }
        
    }
    func match(_ match: GKMatch, didReceive data: Foundation.Data, fromRemotePlayer player: GKPlayer){
        
        if(gameOver){
            return;
        }
        if(variables.background){
            match.disconnect()
        }
        //println("called")
        if(!randReceived){
            levelLabel.text = "Match Against "+(match.players[0] ).displayName!
            self.addChild(levelLabel)
            //println(levelLabel.text)
            randReceived=true
            var number: Int = 0
            number = data.withUnsafeBytes {
                (pointer: UnsafePointer<Int>) -> Int in
                return pointer.pointee
            }
            
            if(myNum>number){
                server=true
                
            }
            
            else{
                
                ball.curveX=0
                ball.curveY=0
            }
            /*levelLabel.text = "M: " + String(stringInterpolationSegment: myNum) + " T: " + String(stringInterpolationSegment: number) + " S: " + String(stringInterpolationSegment: server)*/
            
           // println("Server: " + server.description)
            menuButton.texture = SKTexture(imageNamed: "Disconnect")
            menuButtonPushed.texture = SKTexture(imageNamed: "DisconnectPushed")
            gameStarted=true
            let rect=Rect3D(x: -3, y: -2, z: 8, width: 6, height: 4, back: 0)
            self.addChild(rect.rectNodeXY(Double(screenWidth),screeny:Double(screenHeight), zoom: zoom))
            let rect2=Rect3D(x: -3, y: -2, z: 10, width: 6, height: 4, back: 0)
            self.addChild(rect2.rectNodeXY(Double(screenWidth),screeny:Double(screenHeight), zoom: zoom))
            var rect3=Rect3D(x: -3, y: -2, z: 12, width: 6, height: 4, back: 0)
            self.addChild(rect3.rectNodeXY(Double(screenWidth),screeny:Double(screenHeight), zoom: zoom))
            var rect4=Rect3D(x: -3, y: -2, z: 14, width: 6, height: 4, back: 0)
            self.addChild(rect4.rectNodeXY(Double(screenWidth),screeny:Double(screenHeight), zoom: zoom))
            var rect5=Rect3D(x: -3, y: -2, z: 16, width: 6, height: 4, back: 0)
            self.addChild(rect5.rectNodeXY(Double(screenWidth),screeny:Double(screenHeight), zoom: zoom))
            var rect6=Rect3D(x: -3, y: -2, z: 18, width: 6, height: 4, back: 0)
            self.addChild(rect6.rectNodeXY(Double(screenWidth),screeny:Double(screenHeight), zoom: zoom))
            var rect7=Rect3D(x: -3, y: -2, z: 20, width: 6, height: 4, back: 0)
            self.addChild(rect7.rectNodeXY(Double(screenWidth),screeny:Double(screenHeight), zoom: zoom))
            var rect8=Rect3D(x: -3, y: -2, z: 22, width: 6, height: 4, back: 0)
            self.addChild(rect8.rectNodeXY(Double(screenWidth),screeny:Double(screenHeight), zoom: zoom))
            var rect9=Rect3D(x: -3, y: -2, z: 24, width: 6, height: 4, back: 0)
            self.addChild(rect9.rectNodeXY(Double(screenWidth),screeny:Double(screenHeight), zoom: zoom))
            var line1=Line3D(x: -3, y: -2, z: 8, x2: -3, y2: -2, z2: 24)
            self.addChild(line1.lineNode(Double(screenWidth),screeny:Double(screenHeight), zoom: zoom))
            var line2=Line3D(x: 3, y: -2, z: 8, x2: 3, y2: -2, z2: 24)
            self.addChild(line2.lineNode(Double(screenWidth),screeny:Double(screenHeight), zoom: zoom))
            var line3=Line3D(x: 3, y: 2, z: 8, x2: 3, y2: 2, z2: 24)
            self.addChild(line3.lineNode(Double(screenWidth),screeny:Double(screenHeight), zoom: zoom))
            var line4=Line3D(x: -3, y: 2, z: 8, x2: -3, y2: 2, z2: 24)
            self.addChild(line4.lineNode(Double(screenWidth),screeny:Double(screenHeight), zoom: zoom))
            paddle = playerPaddle.paddleNode(Double(screenWidth), screeny: Double(screenHeight), zoom: zoom, color:0)
            self.addChild(paddle)
            ballNode = ball.ballNode(Double(screenWidth), screeny: Double(screenHeight), zoom: zoom)
            self.addChild(ballNode)
            self.addChild(playerLivesLabel)
            self.addChild(oppLivesLabel)
            //println(paddle.position.x)
            
        }
        else if(gameStarted){
            if(server){
                let gameData = NSKeyedUnarchiver.unarchiveObject(with: data) as! MatchData
                oppPaddle.setMid(Double(gameData.padx),y:Double(gameData.pady))
                oppCurveX = gameData.padCurveX
                oppCurveY = gameData.padCurveY
                response = gameData.response
                
            }
            else{
                let gameData = NSKeyedUnarchiver.unarchiveObject(with: data) as! MatchData
                oppPaddle.setMid(Double(gameData.padx),y:Double(gameData.pady))
                ball.setX(Double(gameData.ballx))
                ball.setY(Double(gameData.bally))
                ball.setZ(Double(32-gameData.ballz))
                ballEdge=gameData.ballEdge
                red = gameData.red
                ballSpeed=gameData.ballSpeed
                ball.curveX=gameData.ballCurveX
                ball.curveY=gameData.ballCurveY
                playerLives = gameData.clientLives
                oppLives = gameData.hostLives
                ball.xSpeed = gameData.ballxSpeed
                ball.ySpeed = gameData.ballySpeed
                playerLivesLabel.text=("Your lives: "+String(playerLives))
                oppLivesLabel.text=("Opponent lives: "+String(oppLives))
                if(playerLives==0){
                    gameOver = true;
                    self.removeAllChildren()
                    levelLabel.text = "You Lost"
                    self.addChild(levelLabel)
                    menuButton.texture = SKTexture(imageNamed: "ExitButton")
                    menuButtonPushed.texture = SKTexture(imageNamed: "ExitButtonPushed")
                    self.addChild(menuButton)
                    self.addChild(retryButton)
                }
                if(oppLives==0){
                    gameOver = true;
                    self.removeAllChildren()
                    levelLabel.text = "You Won!"
                    self.addChild(levelLabel)
                    variables.gems+=10
                    menuButton.texture = SKTexture(imageNamed: "ExitButton")
                    menuButtonPushed.texture = SKTexture(imageNamed: "ExitButtonPushed")
                    self.addChild(menuButton)
                    self.addChild(GemsLabel)
                    self.addChild(gemSprite)
                    self.addChild(retryButton)
                }
                if(gameData.ballEdge){
                    //println("2")
                    if(ball.vec1.x>playerPaddle.vec3.x||ball.vec3.x<playerPaddle.vec1.x||ball.vec1.y>playerPaddle.vec3.y||ball.vec3.y<playerPaddle.vec1.y){
                        self.response=2
                        let gameData = MatchData(padx: Float((playerPaddle.vec3.x+playerPaddle.vec1.x)/2), pady: Float((playerPaddle.vec3.y+playerPaddle.vec1.y)/2), gameOver: false, ballx: 0, bally: 0, ballz: 0,ballEdge:false,response:2,red:false,ballSpeed:0,ballCurveX:0,ballCurveY:0,hostLives:0,clientLives:0,ballxSpeed:0,ballySpeed:0,padCurveX:playerPaddle.getCurveX(),padCurveY:playerPaddle.getCurveY())
                    let data = NSKeyedArchiver.archivedData(withRootObject: gameData)
                    do {
                        try self.match.sendData(toAllPlayers: data, with:GKMatchSendDataMode.reliable)
                    } catch {
                        //NSErrorPointer().memory = error
                    }
                    }
                    else{
                     //   println("1")
                        self.response=1
                        let gameData = MatchData(padx: Float((playerPaddle.vec3.x+playerPaddle.vec1.x)/2), pady: Float((playerPaddle.vec3.y+playerPaddle.vec1.y)/2), gameOver: false, ballx: 0, bally: 0, ballz: 0,ballEdge:false,response:1,red:false,ballSpeed:0,ballCurveX:0,ballCurveY:0,hostLives:0,clientLives:0,ballxSpeed:0,ballySpeed:0,padCurveX:playerPaddle.getCurveX(),padCurveY:playerPaddle.getCurveY())
                        let data = NSKeyedArchiver.archivedData(withRootObject: gameData)
                        do {
                            try self.match.sendData(toAllPlayers: data, with:GKMatchSendDataMode.reliable)
                        } catch /*var error as NSError */{
                           // NSErrorPointer().memory = error
                        }
                    }
                }
            }
        }
    
        
    }
    
    func match(_ match: GKMatch, player: GKPlayer, didChange state: GKPlayerConnectionState){
        if(gameOver){
            return;
        }
        if(variables.background){
            gameOver = true
            self.removeAllChildren()
            levelLabel.text = "You Disconnected"
            menuButton.texture = SKTexture(imageNamed: "ExitButton")
            menuButtonPushed.texture = SKTexture(imageNamed: "ExitButtonPushed")
            self.addChild(menuButton)
            self.addChild(retryButton)
            self.addChild(levelLabel)
            return;
            
        }
        
       // println("called")
        /*if(state==GKPlayerConnectionState.StateConnected){
            println("connected")
        }
        if(state==GKPlayerConnectionState.StateDisconnected){
            println("Disconn")
        }
        if(state==GKPlayerConnectionState.StateUnknown){
            println("unknown")
        }*/
        //println(player.displayName)
        if(state == GKPlayerConnectionState.stateDisconnected){
            if(player.playerID == GKLocalPlayer.localPlayer().playerID){
                levelLabel.text = "You Disconnected"
            }
            else{
                gameOver = true;
                levelLabel.text = "Your opponent disconnected"
                self.removeAllChildren()
                levelLabel.text = "Your opponent disconnected"
                self.addChild(levelLabel)
                variables.gems+=10
                menuButton.texture = SKTexture(imageNamed: "ExitButton")
                menuButtonPushed.texture = SKTexture(imageNamed: "ExitButtonPushed")
                self.addChild(menuButton)
                self.addChild(GemsLabel)
                self.addChild(gemSprite)
                self.addChild(retryButton)
                
            }
        }
        
        
    }
    
    
   
}
