//
//  MustachePaddle.swift
//  CBSK
//
//  Created by Jamal Hashim on 11/2/15.
//  Copyright (c) 2015 Jamal Hashim. All rights reserved.
//

import UIKit
import SpriteKit
class MustachePaddle: Paddle {
    override init(z:Double){
        super.init(z: z)
        self.curve = 1.1
        self.power = 1.1
        self.price = 1000
    }
    
    override func paddleNode(_ screenx:Double,screeny:Double,zoom:Double,color:Int)->SKSpriteNode{
        
        let width:Double = (vec2.convertToX(screenx, zoom:zoom)-vec1.convertToX(screenx, zoom:zoom))
        let height:Double=(vec3.convertToY(screeny, zoom:zoom)-vec2.convertToY(screeny, zoom:zoom))
        let x = vec1.convertToX(screenx, zoom: zoom)
        let y = vec1.convertToY(screeny, zoom: zoom)
        let x2=vec3.convertToX(screenx, zoom: zoom)
        let y2=vec3.convertToY(screeny, zoom: zoom)
        
        var rect:SKSpriteNode = SKSpriteNode()
        
        rect = SKSpriteNode(imageNamed:"Mustache")
        rect.zPosition=0.7
        
        let scalex = width/Double(rect.frame.width)
        let scaley = height/Double(rect.frame.height)
        rect.xScale=CGFloat(scalex)
        rect.yScale=CGFloat(scaley)
        rect.position=CGPoint(x:(x+x2)/2, y:(y+y2)/2)
        //rect.fillColor = SKColor.whiteColor()
        //rect.strokeColor=SKColor.blueColor()
        
        return rect
        
    }
}
