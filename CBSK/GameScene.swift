//
//  GameScene.swift
//  CBSK
//
//  Created by Jamal Hashim on 9/29/15.
//  Copyright (c) 2015 Jamal Hashim. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var lastUpdateTimeInterval: CFTimeInterval = 0
    var paddletouched=false
    var paddle:SKSpriteNode=SKSpriteNode();
    var paddleOpp:SKSpriteNode=SKSpriteNode();
    let vecb1:Vector=Vector(x: -3, y: -2, z: 8)
    let vecb2:Vector=Vector(x: 3, y: 2, z: 8)
    var screenWidth:Double=0
    var screenHeight:Double=0
    var zoom:Double=0
    let playerPaddle:Paddle = variables.paddle
    let oppPaddle:Paddle = OppPaddle(z: 24)
    let ball = Ball(x:-0.25,y:-0.25,z:8);
    var ballNode:SKSpriteNode = SKSpriteNode()
    var ballRect:Rect3D = Rect3D(x: -3, y: -2, z: 8, width: 6, height: 4, back: 0)
    var inPlay=true
    var ballRectNode:SKShapeNode = SKShapeNode()
    var ballSpeed:Double = 13
    var level:Double = 1
    var playerLivesLabel = SKLabelNode()
    var oppLivesLabel = SKLabelNode()
    var scoreLabel = SKLabelNode()
    var earnedLabel = SKLabelNode()
    var playerLives = 5
    var oppLives = 3
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
    var gemEarned = false
    var gemNode:SKSpriteNode = SKSpriteNode()
    var gem:Gem = Gem(xMid: 0, yMid: 0, zMid: 0)
    var gameOver = false
    override func didMove(to view: SKView) {

        self.removeAllChildren()
        screenWidth=Double(view.bounds.size.width)
        screenHeight=Double(view.bounds.size.height)
        zoom = Double(view.bounds.size.width)*1.05
        playerLives=5
        oppLives=3
        level=1
        inPlay=true
        
        pause = false
        ball.zSpeed = -ballSpeed
        ball.xSpeed=0
        ball.ySpeed = 0
        ball.curveX=0
        ball.curveY=0
        score = 0
        toBeEarned = 3000
        playerPaddle.resetPoints()
       
        
        gem = Gem(xMid: Double(arc4random_uniform(500))/100 - 2.5, yMid: (Double(arc4random_uniform(300))/100)-1.5, zMid: 21)
        //println(gem.vec1.x)
       // gem = Gem(xMid: 0, yMid: 0, zMid: 21)
        gemNode = gem.gemNode(screenWidth, screeny: screenHeight, zoom: zoom)
        
        scoreLabel.text = "Total Score: " + String(score)
        scoreLabel.fontSize = 15;
        //scoreLabel.xScale = 100/scoreLabel.frame.width
        //scoreLabel.yScale = scoreLabel.xScale
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.bottom
        scoreLabel.position = CGPoint(x: 5, y: 5)
        scoreLabel.zPosition=0.9
        scoreLabel.fontName="Arial-Bold"
        
        earnedLabel.text = String("Level Score: " + String(toBeEarned))
        earnedLabel.fontSize = 15;
        //earnedLabel.xScale = 100/earnedLabel.frame.width
        //earnedLabel.yScale = earnedLabel.xScale
        earnedLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        earnedLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.bottom
        earnedLabel.position = CGPoint(x: screenWidth-5, y: 5)
        earnedLabel.zPosition = 0.9
        earnedLabel.fontName="Arial-Bold"
        
        self.addChild(earnedLabel)
        self.addChild(scoreLabel)
        self.addChild(ballNode)
        self.addChild(gemNode)
        
        //println(gemNode.frame)
       // println(view.bounds.size.width)
        
        
        
        self.backgroundColor=SKColor.black;
        self.scaleMode = SKSceneScaleMode.resizeFill
        
        translucentRectNode = SKShapeNode(rectOf: CGSize(width: screenWidth, height: screenHeight))
        translucentRectNode.position = CGPoint(x: screenWidth/2, y: screenHeight/2)
        translucentRectNode.fillColor = SKColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.5)
        translucentRectNode.strokeColor = SKColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.5)
        translucentRectNode.zPosition=0.95
        resumeButtonNode.xScale = (CGFloat(screenWidth/6.5))/resumeButtonNode.frame.width
        resumeButtonNode.yScale=resumeButtonNode.xScale
        resumeButtonNode.position = CGPoint(x: screenWidth/1.66, y: screenHeight/2)
        resumeButtonNode.zPosition=1
        resumeButtonPushedNode.xScale = (CGFloat(screenWidth/6.5))/resumeButtonPushedNode.frame.width
        resumeButtonPushedNode.yScale=resumeButtonPushedNode.xScale
        resumeButtonPushedNode.position = CGPoint(x: screenWidth/1.66, y: screenHeight/2)
        resumeButtonPushedNode.zPosition=1
        
        menuButtonNode.xScale = (CGFloat(screenWidth/6.5))/menuButtonNode.frame.width
        menuButtonNode.yScale=menuButtonNode.xScale
        menuButtonNode.position = CGPoint(x: screenWidth/2.5, y: screenHeight/2)
        menuButtonNode.zPosition=1
        menuButtonPushedNode.xScale = (CGFloat(screenWidth/6.5))/menuButtonPushedNode.frame.width
        menuButtonPushedNode.yScale=menuButtonPushedNode.xScale
        menuButtonPushedNode.position = CGPoint(x: screenWidth/2.5, y: screenHeight/2)
        menuButtonPushedNode.zPosition=1
        
        playerLivesLabel.text=("Your lives: "+String(playerLives))
        
        playerLivesLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        playerLivesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        playerLivesLabel.position = CGPoint(x: screenWidth-20, y: screenHeight-33)
        playerLivesLabel.fontSize=15
        playerLivesLabel.fontName="Arial-Bold"
        

        
        
        levelLabel.text=("Level: "+String(Int(level)))
        
        levelLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        levelLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        levelLabel.position = CGPoint(x: screenWidth/2, y: screenHeight-10)
        levelLabel.fontSize=20
        levelLabel.fontName="Arial-Bold"
        
        oppLivesLabel.text=("Opponent lives: "+String(oppLives))
        
        oppLivesLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        oppLivesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        oppLivesLabel.position = CGPoint(x: 20, y: screenHeight-33)
        oppLivesLabel.fontSize=15
        oppLivesLabel.fontName="Arial-Bold"
        
        
        pauseNode.xScale = 22/pauseNode.frame.width
        pauseNode.yScale = 22/pauseNode.frame.height
        pauseNode.position=CGPoint(x: 13, y: screenHeight-15)
        
        pausePushedNode.xScale = 22/pausePushedNode.frame.width
        pausePushedNode.yScale = 22/pausePushedNode.frame.height
        pausePushedNode.position=CGPoint(x: 13, y: screenHeight-15)
        
        
        playerLivesLabel.zPosition=0.5
        oppLivesLabel.zPosition=0.5
        levelLabel.zPosition=0.5
        self.addChild(playerLivesLabel)
        self.addChild(oppLivesLabel)
        self.addChild(levelLabel)
        self.addChild(pauseNode)
        
        paddle.position.x=200
        paddle.position.y=150
        zoom = Double(view.bounds.size.width)*1.05
        playerPaddle.setMid(0, y: 0)
        paddle = playerPaddle.paddleNode(Double(view.bounds.size.width),screeny: Double(view.bounds.size.height), zoom: zoom,color:0)
       
        
        paddleOpp = oppPaddle.paddleNode(Double(view.bounds.size.width),screeny: Double(view.bounds.size.height), zoom: zoom,color:1)
        self.addChild(paddleOpp)
        paddle.name="pad"
        
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
        let gemRect=Rect3D(x: -3, y: -2, z: 21, width: 6, height: 4, back: 0)
        self.addChild(gemRect.rectNodeXY(Double(view.bounds.size.width),screeny: Double(view.bounds.size.height), zoom: zoom,color: SKColor.white))
        let line1=Line3D(x: -3, y: -2, z: 8, x2: -3, y2: -2, z2: 24)
        self.addChild(line1.lineNode(Double(view.bounds.size.width),screeny: Double(view.bounds.size.height), zoom: zoom))
        let line2=Line3D(x: 3, y: -2, z: 8, x2: 3, y2: -2, z2: 24)
        self.addChild(line2.lineNode(Double(view.bounds.size.width),screeny: Double(view.bounds.size.height), zoom: zoom))
        let line3=Line3D(x: 3, y: 2, z: 8, x2: 3, y2: 2, z2: 24)
        self.addChild(line3.lineNode(Double(view.bounds.size.width),screeny: Double(view.bounds.size.height), zoom: zoom))
        let line4=Line3D(x: -3, y: 2, z: 8, x2: -3, y2: 2, z2: 24)
        self.addChild(line4.lineNode(Double(view.bounds.size.width),screeny: Double(view.bounds.size.height), zoom: zoom))
        
        self.addChild(paddle)
      
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in (touches ) {
            let location = touch.location(in: self)
            if (!pause && pauseNode.contains(location)){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                pauseNode.removeFromParent()
                self.addChild(pausePushedNode)
            }
            if(pause && resumeButtonNode.contains(location)){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                resumeButtonNode.removeFromParent()
                self.addChild(resumeButtonPushedNode)
            }
            if(pause && menuButtonNode.contains(location)){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                menuButtonNode.removeFromParent()
                self.addChild(menuButtonPushedNode)
            }
        }
    }
    
    override func touchesMoved(_ touches:  Set<UITouch>, with event: UIEvent?) {
       
        for touch:AnyObject in touches {
            let location = touch.location(in: self)
            if(paddletouched==true){
                let location = touch.location(in: self)
                paddle.position = CGPoint(x: location.x, y: location.y)
                
            }
            
            if(!pause && pauseNode.contains(location)&&pausePushedNode.parent != self){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                pauseNode.removeFromParent()
                self.addChild(pausePushedNode)
            }
            if(pause && menuButtonNode.contains(location)&&menuButtonPushedNode.parent != self){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                menuButtonNode.removeFromParent()
                self.addChild(menuButtonPushedNode)
            }
            if(pause && resumeButtonNode.contains(location)&&resumeButtonPushedNode.parent != self){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                resumeButtonNode.removeFromParent()
                self.addChild(resumeButtonPushedNode)
            }
            
            let touchedNode = atPoint(location)
            if(touchedNode.name=="pad"){
            paddletouched=true
            touchedNode.position = CGPoint(x: location.x, y: location.y)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        paddletouched=false
        
        
        for touch in (touches ) {
            let location = touch.location(in: self)
            
            if(pausePushedNode.contains(location) && !pause){
                pause=true
                self.addChild(translucentRectNode)
                self.addChild(resumeButtonNode)
                self.addChild(menuButtonNode)
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                return
                
            }
            else if(pausePushedNode.parent==self){
                pausePushedNode.removeFromParent()
                self.addChild(pauseNode)
            }
            if(pause){
                if(resumeButtonPushedNode.contains(location)){
                    pause=false
                    resumeButtonPushedNode.removeFromParent()
                    translucentRectNode.removeFromParent()
                    resumeButtonNode.removeFromParent()
                    menuButtonPushedNode.removeFromParent()
                    menuButtonNode.removeFromParent()
                    run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                }
                else if(resumeButtonPushedNode.parent==self){
                    resumeButtonPushedNode.removeFromParent()
                    if(resumeButtonNode.parent != self){
                    self.addChild(resumeButtonNode)
                    }
                }
                    
                if(menuButtonPushedNode.contains(location)){
                    menuButtonPushedNode.removeFromParent()
                    
                    self.addChild(menuButtonNode)
                    let transition = SKTransition.fade(withDuration: 0.5)
                    
                    let nextScene = StartScene(size: scene!.size)
                    nextScene.scaleMode = .aspectFill
                    run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                    scene?.view?.presentScene(nextScene, transition: transition)
                }
                else if(menuButtonPushedNode.parent==self){
                    menuButtonPushedNode.removeFromParent()
                    if(menuButtonNode.parent != self){
                    self.addChild(menuButtonNode)
                    }
                }
            }
        }
    }
    override func update(_ currentTime: TimeInterval) {
        
        if(pause){
            return;
        }
        /* Called before each frame is rendered */
        
        if Double(paddle.position.x-paddle.frame.width/2) <= vecb1.convertToX(screenWidth, zoom: zoom){
            paddle.position.x=CGFloat(vecb1.convertToX(screenWidth, zoom: zoom))+paddle.frame.width/2
        }
        if Double(paddle.position.x+paddle.frame.width/2) >= vecb2.convertToX(screenWidth, zoom: zoom){
            paddle.position.x=CGFloat(vecb2.convertToX(screenWidth, zoom: zoom))-paddle.frame.width/2
        }
       
        if Double(paddle.position.y-paddle.frame.height/2) <= vecb1.convertToY(screenHeight, zoom: zoom){
            paddle.position.y=CGFloat(vecb1.convertToY(screenHeight, zoom: zoom))+paddle.frame.height/2
        }
        if Double(paddle.position.y+paddle.frame.height/2) >= vecb2.convertToY(screenHeight, zoom: zoom){
            paddle.position.y=CGFloat(vecb2.convertToY(screenHeight, zoom: zoom))-paddle.frame.height/2
        }
        
        playerPaddle.setLoc(paddle, screenx: screenWidth, screeny: screenHeight, zoom: zoom)
      //  playerPaddle.printVectors()
        
        playerPaddle.addPoint()
        oppPaddle.addPoint()
        if(gameOver){
            return;
        }
        var delta: CFTimeInterval = currentTime - lastUpdateTimeInterval
        
        
        
        if(inPlay==false){
            
          
            
            if(delta<2||playerLives==0){
                
               // //ballNode.removeFromParent()
                //ballNode.strokeColor=SKColor.redColor()
                //ballNode.fillColor=SKColor.redColor()
                ballNode.texture = SKTexture(imageNamed: "Ball2")
               // self.addChild(ballNode)
                return;
            }
            else{
                if(oppLives==0){
                    level += 1
                    if(Int(level)==11){
                    score+=toBeEarned
                    scoreLabel.text = String("Total Score: " + String(score))
                    variables.level = Int(level)
                    variables.score = score
                    let transition = SKTransition.fade(withDuration: 0.5)
                    
                    let nextScene = WinScene(size: scene!.size)
                    nextScene.scaleMode = .aspectFill
                    
                    scene?.view?.presentScene(nextScene, transition: transition)
                    gameOver = true
                    return;
                    }
                    oppLives=3
                    oppLivesLabel.text=("Opponent lives: "+String(oppLives))
                    ballSpeed += 1.5
                    score+=toBeEarned
                    scoreLabel.text = String("Total Score: " + String(score))
                    toBeEarned = 3000
                    gem=Gem(xMid: Double(arc4random_uniform(500))/100 - 2.5, yMid: (Double(arc4random_uniform(300))/100)-1.5, zMid: 21)
                    gemNode.removeFromParent()
                    gemNode = gem.gemNode(screenWidth, screeny: screenHeight, zoom: zoom)
                    self.addChild(gemNode)
                    gemEarned = false
                    //println(gemNode.frame)
                    //earnedLabel.text = String(toBeEarned)
                   
                }
                levelLabel.text=("Level: "+String(Int(level)))
                inPlay=true
                ball.zSpeed = -ballSpeed
                ball.setZ((23))
                ball.setX((-0.25))
                ball.setY((-0.25))
                ball.xSpeed=0
                ball.ySpeed=0
                ball.curveX=0
                ball.curveY=0
                delta=0
            }
         
            
        }
        
        lastUpdateTimeInterval = currentTime
   
        if(delta>1){
            return
        }
       
        toBeEarned-=Int((delta*75))
        if(toBeEarned<0){
            toBeEarned = 0
        }
        let temp = String("Level Score: " + String(toBeEarned))
        earnedLabel.text = temp
       
        
        oppPaddle.moveTo((level*1.45-1)*delta, loc: ball.midLoc())
        
        paddleOpp.removeFromParent()
        paddleOpp = oppPaddle.paddleNode(screenWidth, screeny: screenHeight, zoom: zoom, color: 1)
        self.addChild(paddleOpp)
        
        ballNode.removeFromParent()
        ball.updateBall(delta)
        if(gem.inRange(ball) && !gemEarned){
            //run(SKAction.playSoundFileNamed("Gem.wav", waitForCompletion: false))
            variables.gems += 1
            gemNode.removeFromParent()
            gemEarned=true
            score+=1000
            scoreLabel.text = "Total Score: " + String(score)
        }
        if(ball.vec1.z<=8){
           
            if(ball.vec1.x>playerPaddle.vec3.x||ball.vec3.x<playerPaddle.vec1.x||ball.vec1.y>playerPaddle.vec3.y||ball.vec3.y<playerPaddle.vec1.y){
                inPlay=false
                ballNode = ball.ballNode(screenWidth, screeny: screenHeight, zoom: zoom)
                ballRectNode.removeFromParent()
                ballRect.setZ(ball.vec3.z)
                ballRectNode=ballRect.rectNodeXY(screenWidth, screeny: screenHeight, zoom: zoom, color: SKColor.blue)
                ballRectNode.zPosition = -1
                self.addChild(ballRectNode)
                self.addChild(ballNode)
                playerLives -= 1
                
                let temp = ("Your lives: "+String(playerLives))
            
                
                playerLivesLabel.text = temp
                if(playerLives==0){
                    //ballNode.removeFromParent()
                    //ballNode.strokeColor=SKColor.redColor()
                    //ballNode.fillColor=SKColor.redColor()
                    ballNode.texture = SKTexture(imageNamed: "Ball2")
                    //self.addChild(ballNode)
                    variables.level = Int(level)
                    variables.score = score
                    let transition = SKTransition.fade(withDuration: 2)
                    
                    let nextScene = GameOverScene(size: scene!.size)
                    nextScene.scaleMode = .aspectFill
                    
                    scene?.view?.presentScene(nextScene, transition: transition)
                    
                }
                return;
            }
            run(SKAction.playSoundFileNamed("Ball.mp3", waitForCompletion: false))
            ball.curveX=playerPaddle.getCurveX()
            ball.curveY=playerPaddle.getCurveY()
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
            
            ball.zSpeed = ballSpeed*playerPaddle.power
            ball.setZ(ball.vec1.z+0.05)
        }
        
        if(ball.vec1.z>=24){
            if(ball.vec1.x>oppPaddle.vec3.x||ball.vec3.x<oppPaddle.vec1.x||ball.vec1.y>oppPaddle.vec3.y||ball.vec3.y<oppPaddle.vec1.y){
                ballRectNode.removeFromParent()
                ballNode = ball.ballNode(screenWidth, screeny: screenHeight, zoom: zoom)
                ballRect.setZ(ball.vec3.z)
                ballRectNode=ballRect.rectNodeXY(screenWidth, screeny: screenHeight, zoom: zoom, color: SKColor.blue)
                ballRectNode.zPosition = -1
                self.addChild(ballRectNode)
                self.addChild(ballNode)
                inPlay=false
                oppLives -= 1
                oppLivesLabel.text=("Opponent lives: "+String(oppLives))
                return;
            }
            run(SKAction.playSoundFileNamed("Ball.mp3", waitForCompletion: false))
            ball.zSpeed = -ballSpeed * oppPaddle.power
            //ball.curveX=0
            //ball.curveY=0
            ball.curveX=oppPaddle.getCurveX()
            ball.curveY=oppPaddle.getCurveY()
            
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
        
        
        ballRectNode.removeFromParent()
        ballNode = ball.ballNode(screenWidth, screeny: screenHeight, zoom: zoom)
        ballRect.setZ(ball.vec3.z)
        ballRectNode=ballRect.rectNodeXY(screenWidth, screeny: screenHeight, zoom: zoom, color: SKColor.blue)
        ballRectNode.zPosition = -1
        self.addChild(ballRectNode)
        self.addChild(ballNode)
        
        
    }
    
    func getLevel()->Int{
        return Int(level)
    }
    func why(_ delta:Double){
        
        earnedLabel.removeFromParent()
        toBeEarned-=Int((delta*75))
        let temp = String(toBeEarned)
        earnedLabel.text = temp
        self.addChild(earnedLabel)
        
    }
}



