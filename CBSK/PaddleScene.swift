//
//  GameScene.swift
//  CBSK
//
//  Created by Jamal Hashim on 9/29/15.
//  Copyright (c) 2015 Jamal Hashim. All rights reserved.
//

import SpriteKit
import StoreKit
import Foundation
import GameKit

class PaddleScene: SKScene, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    var screenWidth:Double=0
    var screenHeight:Double=0
    var zoom:Double=0
    var backButton:SKSpriteNode = SKSpriteNode()
    var backButtonPushed:SKSpriteNode = SKSpriteNode()
    let titleNode = SKLabelNode(text: "Paddle Select")
    var paddles = [SKSpriteNode](repeating: SKSpriteNode(), count: 6)
    let gemsNode = SKLabelNode(text: String(variables.gems))
    let gemSprite = SKSpriteNode(imageNamed: "GemOpaque")
    var selectRect = SKShapeNode()
    var buyButton:SKSpriteNode = SKSpriteNode()
    var buyLabel:SKLabelNode = SKLabelNode(text: "Buy 5000 Gems for $1.99:")
    
    var transaction=false
    var productIDs: Array<String?> = []
    var productsArray: Array<SKProduct?> = []
    override func willMove(from view: SKView) {
        SKPaymentQueue.default().remove(self)
    }
    override func didMove(to view: SKView) {
        productIDs.append("GEMS5K")
        self.removeAllChildren()
        screenWidth=Double(view.bounds.size.width)
        screenHeight=Double(view.bounds.size.height)
        zoom = Double(view.bounds.size.width)*1.05
        setUp(paddles[0], type: Paddle(z: 11), name: "The Classic", x: screenWidth*1/4, y: screenHeight*0.66, assignTo: 0)
        setUp(paddles[1], type: CrossPaddle(z: 11), name: "The Cross", x: screenWidth*2/4, y: screenHeight*0.66, assignTo: 1)
        setUp(paddles[2], type: FractalPaddle(z: 11), name: "The Fractal", x: screenWidth*3/4, y: screenHeight*0.66, assignTo: 2)
        setUp(paddles[3], type: InfinityPaddle(z: 11), name: "The Infinite", x: screenWidth*1/4, y: screenHeight*0.33, assignTo: 3)
        setUp(paddles[4], type: MustachePaddle(z: 11), name: "The Mustache", x: screenWidth*2/4, y: screenHeight*0.33, assignTo: 4)
        setUp(paddles[5], type: SkullPaddle(z: 11), name: "The Skull", x: screenWidth*3/4, y: screenHeight*0.33, assignTo: 5)
        
        
        
        
        self.scaleMode = SKSceneScaleMode.resizeFill
        //print("in")
        
        
        self.backgroundColor = SKColor.black
        
        titleNode.fontSize=100
        titleNode.fontName = "Arial-Bold"
        titleNode.xScale=CGFloat(screenWidth/2)/titleNode.frame.width
        titleNode.yScale=titleNode.xScale
        
        titleNode.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        titleNode.position=CGPoint(x: screenWidth/2, y: screenHeight-5)
        
        backButton = SKSpriteNode(imageNamed:"BackButton")
        backButton.xScale = (CGFloat(screenWidth/6.5))/backButton.frame.width
        backButton.yScale=backButton.xScale
        //startButton.yScale = (CGFloat(screenWidth/6.5))/startButton.frame.width
        backButton.name="Start Button"
        backButton.zPosition = -1
        backButton.position = CGPoint(x:backButton.frame.width/2+10, y: CGFloat(screenHeight-Double(backButton.frame.height/2+10)))
        
        buyButton = SKSpriteNode(imageNamed:"Buy")
        buyButton.xScale = (CGFloat(screenWidth/6.5))/buyButton.frame.width
        buyButton.yScale=buyButton.xScale
        //startButton.yScale = (CGFloat(screenWidth/6.5))/startButton.frame.width
        buyButton.name="Start Button"
        buyButton.zPosition = -1
        buyButton.position = CGPoint(x:backButton.frame.width/2+10, y: CGFloat(screenHeight-Double(backButton.frame.height/2+10)))
        
        buyLabel.fontName = "Arial-Bold"
        buyLabel.fontSize = 20
        buyLabel.horizontalAlignmentMode = .left
        buyLabel.verticalAlignmentMode = .center
        let total = buyLabel.frame.width+10+buyButton.frame.width
        buyLabel.position = CGPoint(x:CGFloat(screenWidth/2)-total/2, y: CGFloat(screenHeight*0.1))
        buyButton.position = CGPoint(x:CGFloat(screenWidth/2)+total/2+10-buyButton.frame.width/2, y: CGFloat(screenHeight*0.1))
        buyButton.name="unpushed"
        
        backButtonPushed = SKSpriteNode(imageNamed:"BackButtonPushed")
        backButtonPushed.xScale = (CGFloat(screenWidth/6.5))/backButtonPushed.frame.width
        backButtonPushed.yScale=backButton.xScale
        ///startButtonPushed.yScale = (CGFloat(screenWidth/6.5))/startButtonPushed.frame.width
        backButtonPushed.name="Start Button Pushed"
        backButtonPushed.zPosition = -1
        backButtonPushed.position = CGPoint(x:backButtonPushed.frame.width/2+10, y: CGFloat(screenHeight-Double(backButtonPushed.frame.height/2+10)))
        
        gemsNode.fontSize = 20
        gemsNode.fontName = "Arial-Bold"
        gemsNode.verticalAlignmentMode = .center
        gemsNode.position = CGPoint(x: CGFloat(screenWidth-Double(gemsNode.frame.width/2+30)), y: CGFloat(screenHeight-Double(gemsNode.frame.height/2+10)))
        
        gemSprite.xScale = 20/gemSprite.frame.width
        gemSprite.yScale=gemSprite.xScale
        gemSprite.position = CGPoint(x: CGFloat(screenWidth-Double(gemSprite.frame.width/2+5)), y: CGFloat(screenHeight-Double(gemsNode.frame.height/2+10)))
        
        self.addChild(gemSprite)
        self.addChild(gemsNode)
        self.addChild(backButton)
        self.addChild(titleNode)
        self.addChild(buyButton)
        self.addChild(buyLabel)
        //requestProductInfo()
        //var req = SKProductsRequest(productIdentifiers: "GEMS5K" as! Set<String>)
        //req.delegate = self
        //req.start()
        //self.addChild(startLabel)
        // print(SKColor.greenColor().CGColor)
        // print(SKColor.greenColor().CIColor.green())
        //print(SKColor.greenColor().CIColor.blue())
       
        
        
    }
    func buyProduct() {
        //print("buy " + productsArray[0].productIdentifier)
        let pay = SKPayment(product: productsArray[0]!)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(pay as SKPayment)
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
       // print("add payment")
        
        for transaction:AnyObject in transactions {
            let trans = transaction as! SKPaymentTransaction
          //  print(trans.error)
            
            switch trans.transactionState {
                
            case .purchased:
               // print("buy, ok unlock iap here")
                //print(productsArray[0].productIdentifier)
                
                let prodID = productsArray[0]?.productIdentifier as! String
                switch prodID {
                case "GEMS5K":
                    //print("gems")
                    variables.gems+=5000
                    gemsNode.text=String(variables.gems)
                    gemsNode.fontSize = 20
                    gemsNode.fontName = "Arial-Bold"
                    gemsNode.verticalAlignmentMode = .center
                    gemsNode.position = CGPoint(x: CGFloat(screenWidth-Double(gemsNode.frame.width/2+30)), y: CGFloat(screenHeight-Double(gemsNode.frame.height/2+10)))
                    
                    /*gemSprite.xScale = 20/gemSprite.frame.width
                    gemSprite.yScale=gemSprite.xScale
                    gemSprite.position = CGPoint(x: CGFloat(screenWidth-Double(gemSprite.frame.width/2+5)), y: CGFloat(screenHeight-Double(gemsNode.frame.height/2+10)))*/
                    //removeAds()
                case "bundle id": break
                    //print("add coins to account")
                    //addCoins()
                default: break
                    //print("IAP not setup")
                }
                
                queue.finishTransaction(trans)
                //self.transaction=false
                break;
            case .failed:
                //print("buy error")
                queue.finishTransaction(trans)
               // self.transaction=false

                break;
            default:
               // print("default")
                //self.transaction=false
                break;
                
            }
        }
    }
    
    // 6
    func finishTransaction(_ trans:SKPaymentTransaction)
    {
        transaction=false
       // print("finish trans")
    }
    
    /*func paymentQueueRestoreCompletedTransactionsFinished(queue: SKPaymentQueue!) {
        print("transactions restored")
        
        var purchasedItemIDS = []
        for transaction in queue.transactions {
            var t: SKPaymentTransaction = transaction as SKPaymentTransaction
            
            let prodID = t.payment.productIdentifier as String
            
            switch prodID {
            case "GEMS5K":
                print("GEMS")
                //println("remove ads")
                //removeAds()
            case "bundleid":
                print("hi")
                //println("add coins to account")
                //addCoins()
            default:
                print("IAP not setup")
            }
            
        }
    }*/
    
    //7
    func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction])
    {
        transaction=false
        buyButton.texture = SKTexture(imageNamed: "Buy")
       // print("remove trans");
    }
    func requestProductInfo() {
        if SKPaymentQueue.canMakePayments() {
            let productIdentifiers = NSSet(array: productIDs)
            let productRequest = SKProductsRequest(productIdentifiers: productIdentifiers as! Set<String>)
            
            productRequest.delegate = self
            productRequest.start()
        }
        else {
            //print("Cannot perform In App Purchases.")
        }
    }
    
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if response.products.count != 0 {
            for product in response.products {
                productsArray.append(product )
            }
            buyProduct()
            //print(productsArray[0].localizedTitle)
            //tblProducts.reloadData()
        }
        else {
            transaction=false
            buyButton.texture = SKTexture(imageNamed: "Buy")
           // print("There are no products.")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches ) {
            let location = touch.location(in: self)
            
            if(backButton.contains(location)){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                backButton.removeFromParent()
                self.addChild(backButtonPushed)
            }
            if(buyButton.contains(location)&&buyButton.name=="unpushed"){
                buyButton.name="pushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                buyButton.texture = SKTexture(imageNamed: "BuyPushed")
            }
        }
    }
    
    override func touchesMoved(_ touches:  Set<UITouch>, with event: UIEvent?) {
        
        for touch:AnyObject in touches {
            let location = touch.location(in: self)
           
            if(backButton.contains(location)&&backButtonPushed.parent != self){
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                backButton.removeFromParent()
                self.addChild(backButtonPushed)
            }
            if(buyButton.contains(location)&&buyButton.name=="unpushed"){
                buyButton.name="pushed"
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                buyButton.texture = SKTexture(imageNamed: "BuyPushed")
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches ) {
            let location = touch.location(in: self)
            
            if(backButtonPushed.contains(location)){
                //print("in")
                backButtonPushed.removeFromParent()
                self.addChild(backButton)
                let transition = SKTransition.fade(withDuration: 0.5)
                
                let nextScene = StartScene(size: scene!.size)
                nextScene.scaleMode = .aspectFill
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                scene?.view?.presentScene(nextScene, transition: transition)
            }
            
            
            if(buyButton.contains(location)){
                //print("in")
                buyButton.name="unpushed"
                //backButtonPushed.removeFromParent()
                buyButton.texture = SKTexture(imageNamed: "Buy")
                run(SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false))
                if(transaction==false){
                transaction=true
                requestProductInfo()
                }
            }
            
                
            if(paddles[0].contains(location)){
                variables.paddle=Paddle(z: 8)
                selectRect.position = paddles[0].position
                
            }
            if(contains(paddles[1], location: location)){
                if(variables.cross==true){
                variables.paddle=CrossPaddle(z: 8)
                selectRect.position = paddles[1].position
                }
                else if(variables.gems-CrossPaddle(z: 0).price>=0){
                    variables.gems -= CrossPaddle(z: 0).price
                    variables.cross=true
                    let rect = SKShapeNode(rectOf: CGSize(width: paddles[1].frame.size.width+1, height: paddles[1].frame.size.height+1))
                    rect.position = paddles[1].position
                    rect.strokeColor = SKColor.black
                    rect.fillColor = SKColor.black
                    rect.zPosition=0.75
                    self.addChild(rect)
                    paddles[1].zPosition=1
                    self.addChild(paddles[1])
                    variables.paddle=CrossPaddle(z: 8)
                    selectRect.position = paddles[1].position
                    gemsNode.text=String(variables.gems)
                    
                    let achieve = GKAchievement(identifier: "grp.cross")
                    achieve.percentComplete=100.0
                    achieve.showsCompletionBanner=true
                    GKAchievement.report([achieve], withCompletionHandler: nil)
                    
                    
                    
                }
            }
            if(contains(paddles[2], location: location)){
                if(variables.fractal==true){
                variables.paddle=FractalPaddle(z: 8)
                selectRect.position = paddles[2].position
                }
                else if(variables.gems-FractalPaddle(z: 0).price>=0){
                    variables.gems -= FractalPaddle(z: 0).price
                    variables.fractal=true
                    let rect = SKShapeNode(rectOf: CGSize(width: paddles[2].frame.size.width+1, height: paddles[2].frame.size.height+1))
                    rect.position = paddles[2].position
                    rect.strokeColor = SKColor.black
                    rect.fillColor = SKColor.black
                    rect.zPosition=0.75
                    self.addChild(rect)
                    paddles[2].zPosition=1
                    self.addChild(paddles[2])
                    variables.paddle=FractalPaddle(z: 8)
                    selectRect.position = paddles[2].position
                    gemsNode.text=String(variables.gems)
                    
                    let achieve = GKAchievement(identifier: "grp.fractal")
                    achieve.percentComplete=100.0
                    achieve.showsCompletionBanner=true
                    GKAchievement.report([achieve], withCompletionHandler: nil)
                }
            }
            if(contains(paddles[3], location: location)){
                if(variables.infinity==true){
                variables.paddle=InfinityPaddle(z: 8)
                selectRect.position = paddles[3].position
                }
                else if(variables.gems-InfinityPaddle(z: 0).price>=0){
                    variables.gems -= InfinityPaddle(z: 0).price
                    variables.infinity=true
                    let rect = SKShapeNode(rectOf: CGSize(width: paddles[3].frame.size.width+1, height: paddles[3].frame.size.height+1))
                    rect.position = paddles[3].position
                    rect.strokeColor = SKColor.black
                    rect.fillColor = SKColor.black
                    rect.zPosition=0.75
                    self.addChild(rect)
                    paddles[3].zPosition=1
                    self.addChild(paddles[3])
                    variables.paddle=InfinityPaddle(z: 8)
                    selectRect.position = paddles[3].position
                    gemsNode.text=String(variables.gems)
                    
                    let achieve = GKAchievement(identifier: "grp.infinite")
                    achieve.percentComplete=100.0
                    achieve.showsCompletionBanner=true
                    GKAchievement.report([achieve], withCompletionHandler: nil)
                }
            }
            if(contains(paddles[4], location: location)){
                if(variables.mustache==true){
                variables.paddle=MustachePaddle(z: 8)
                selectRect.position = paddles[4].position
                }
                else if(variables.gems-MustachePaddle(z: 0).price>=0){
                    variables.gems -= MustachePaddle(z: 0).price
                    variables.mustache=true
                    let rect = SKShapeNode(rectOf: CGSize(width: paddles[4].frame.size.width+1, height: paddles[4].frame.size.height+1))
                    rect.position = paddles[4].position
                    rect.strokeColor = SKColor.black
                    rect.fillColor = SKColor.black
                    rect.zPosition=0.75
                    self.addChild(rect)
                    paddles[4].zPosition=1
                    self.addChild(paddles[4])
                    variables.paddle=MustachePaddle(z: 8)
                    selectRect.position = paddles[4].position
                    gemsNode.text=String(variables.gems)
                    
                    let achieve = GKAchievement(identifier: "grp.mustache")
                    achieve.percentComplete=100.0
                    achieve.showsCompletionBanner=true
                    GKAchievement.report([achieve], withCompletionHandler: nil)
                }
            }
            if(contains(paddles[5], location: location)){
                if(variables.skull==true){
                variables.paddle=SkullPaddle(z: 8)
                selectRect.position = paddles[5].position
                }
                else if(variables.gems-SkullPaddle(z: 0).price>=0){
                    variables.gems -= SkullPaddle(z: 0).price
                    variables.skull=true
                    let rect = SKShapeNode(rectOf: CGSize(width: paddles[5].frame.size.width+1, height: paddles[5].frame.size.height+1))
                    rect.position = paddles[5].position
                    rect.strokeColor = SKColor.black
                    rect.fillColor = SKColor.black
                    rect.zPosition=0.75
                    self.addChild(rect)
                    paddles[5].zPosition=1
                    self.addChild(paddles[5])
                    variables.paddle=SkullPaddle(z: 8)
                    selectRect.position = paddles[5].position
                    gemsNode.text=String(variables.gems)
                    
                    let achieve = GKAchievement(identifier: "grp.skull")
                    achieve.percentComplete=100.0
                    achieve.showsCompletionBanner=true
                    GKAchievement.report([achieve], withCompletionHandler: nil)
                    
                }
                
            }
            else if(backButtonPushed.parent==self){
                backButtonPushed.removeFromParent()
                if(backButton.parent != self){
                self.addChild(backButton)
                }
            }
        }
    }
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        
        
    }
    
    func contains(_ paddle: SKSpriteNode, location: CGPoint)-> Bool{
        let paddleRect = paddle.frame
        if(paddleRect.minX<location.x&&paddleRect.maxX>location.x&&paddleRect.minY<location.y&&paddleRect.maxY>location.y){
            //print("in")
            return true;
        }
        return false
    }
    
    func setUp(_ paddle: SKSpriteNode,type: Paddle,name:String,x:Double,y:Double, assignTo: Int){
        paddles[assignTo] = type.paddleNode(screenWidth, screeny: screenHeight, zoom: zoom,color: 0)
        paddles[assignTo].position = CGPoint(x:CGFloat(x),y:CGFloat(y))
        let nameNode = SKLabelNode(text: name)
        nameNode.fontSize = 20
        nameNode.fontName = "Arial-Bold"
        nameNode.position = CGPoint(x: x, y: y+Double(paddles[assignTo].frame.size.height/2)+3)
        let powerNode = SKLabelNode(text: "Power: " + String(Int(type.power*100+0.1)))
        let curveNode = SKLabelNode(text: "Curve: " + String(Int(type.curve*100+0.1)))
        powerNode.verticalAlignmentMode = .top
        powerNode.fontSize = 14
        powerNode.fontName = "Arial-Bold"
        curveNode.verticalAlignmentMode = .top
        powerNode.position = CGPoint(x: x, y: y-Double(paddles[assignTo].frame.size.height/2)-3)
        curveNode.fontSize = 14
        curveNode.fontName = "Arial-Bold"
        curveNode.position = CGPoint(x: x, y: Double(powerNode.frame.minY-3))
        if(type.price==variables.paddle.price){
            if(selectRect.parent==self){
                selectRect.removeFromParent()
                
            }
            selectRect = SKShapeNode(rectOf: CGSize(width: paddles[assignTo].frame.size.width+2, height: paddles[assignTo].frame.size.height+2))
            selectRect.position = paddles[assignTo].position
            selectRect.zPosition=1
            selectRect.strokeColor = SKColor.green
            self.addChild(selectRect)
        }
        
        self.addChild(nameNode)
        self.addChild(powerNode)
        self.addChild(curveNode)
        if((type is InfinityPaddle && variables.infinity==false)||(type is SkullPaddle && variables.skull==false)||(type is FractalPaddle && variables.fractal==false)||(type is CrossPaddle && variables.cross==false)||(type is MustachePaddle && variables.mustache==false)){
            
            let rect = SKShapeNode(rectOf: CGSize(width: paddles[assignTo].frame.size.width, height: paddles[assignTo].frame.size.height))
            rect.position = paddles[assignTo].position
            rect.strokeColor = SKColor.gray
            rect.fillColor = SKColor.gray
            let label = SKLabelNode(text: String(type.price))
            label.verticalAlignmentMode = .bottom
            label.fontSize = 20
            label.position = CGPoint(x: x, y: y+2)
            label.zPosition=0.5
            let gem = SKSpriteNode(imageNamed: "GemOpaque")
            gem.xScale = 16/gem.frame.width
            gem.yScale=gem.xScale
            gem.position = CGPoint(x: x, y: y - Double(gem.frame.height/2) - 2)
            gem.zPosition=0.5
            
            self.addChild(gem)
            self.addChild(label)
            self.addChild(rect)
            
            return;
            
        }
        self.addChild(paddles[assignTo])
        
    }
    
    
}



