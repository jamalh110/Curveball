
//
//  Ball.swift
//  CBSK
//
//  Created by Jamal Hashim on 10/8/15.
//  Copyright (c) 2015 Jamal Hashim. All rights reserved.
//


//-3,2          3,2



//-3,-2         3,-2

// four        three
//


//one         two

import UIKit
import SpriteKit

class Ball: NSObject {
   
    var vec1:Vector
    var vec2:Vector
    var vec3:Vector
    var vec4:Vector
    var spin:Double=0
    var zSpeed:Double=10
    var spinAngle:Double = 0;
    var xSpeed:Double=0
    var ySpeed:Double=0;
    let width = 0.5
    let height = 0.5
    
    var curveX:Double = 0
    var curveY:Double = 0
    
    
    init(x:Double,y:Double,z:Double){
        
        vec1=Vector(x: x, y:y, z: z)
        vec2=Vector(x: x+width, y:y, z: z)
        vec3=Vector(x: x+width, y:y+height, z: z)
        vec4=Vector(x: x, y:y+height, z: z)
        
    }
    
    func midLoc()->Vector{
        return Vector(x: (vec1.x+vec3.x)/2, y: (vec1.y+vec3.y)/2, z: (vec1.z+vec3.z)/2)
    }
    
    func setZ(_ z:Double){
        vec1.z=z
        vec2.z=z
        vec3.z=z
        vec4.z=z
    }
    func setX(_ x:Double){
        vec1.x=x
        vec2.x=x+width
        vec3.x=x+width
        vec4.x=x
    }
    func setY(_ y:Double){
        vec1.y=y
        vec2.y=y
        vec3.y=y+height
        vec4.y=y+height
    }
    
    func ballNode(_ screenx:Double,screeny:Double,zoom:Double)->SKSpriteNode{
        
        let width:Double = (vec2.convertToX(screenx, zoom:zoom)-vec1.convertToX(screenx, zoom:zoom))
        let height:Double=(vec3.convertToY(screeny, zoom:zoom)-vec2.convertToY(screeny, zoom:zoom))
        let x = vec1.convertToX(screenx, zoom: zoom)
        let y = vec1.convertToY(screeny, zoom: zoom)
        let x2=vec3.convertToX(screenx, zoom: zoom)
        let y2=vec3.convertToY(screeny, zoom: zoom)
        // println(x)
        // println(y)
        // println(width)
        // println(height)
        
        var rect:SKSpriteNode = SKSpriteNode()
        /*if(color==0){
            rect = SKSpriteNode(imageNamed:"paddleblue")
            rect.zPosition=0.7
        }
        if(color==1){
            rect = SKSpriteNode(imageNamed:"paddlered")
            rect.zPosition = -0.7
        }*/
        rect = SKSpriteNode(imageNamed:"Ball")
        let scalex = width/Double(rect.frame.width)
        let scaley = height/Double(rect.frame.height)
        rect.xScale=CGFloat(scalex)
        rect.yScale=CGFloat(scaley)
        rect.position=CGPoint(x:(x+x2)/2, y:(y+y2)/2)
        if(self.vec1.z>16){
            rect.zPosition = -0.5
        }
        else{
            rect.zPosition=0.5
        }
        //rect.fillColor = SKColor.whiteColor()
        //rect.strokeColor=SKColor.blueColor()
        
        return rect
        
    }

    func updateBall(_ time:Double){
        xSpeed+=curveX*time
        ySpeed+=curveY*time
        
        vec1.z+=zSpeed*time;
        vec2.z+=zSpeed*time;
        vec3.z+=zSpeed*time;
        vec4.z+=zSpeed*time;
        vec1.x+=xSpeed*time;
        vec2.x+=xSpeed*time;
        vec3.x+=xSpeed*time;
        vec4.x+=xSpeed*time;
        vec1.y+=ySpeed*time;
        vec2.y+=ySpeed*time;
        vec3.y+=ySpeed*time;
        vec4.y+=ySpeed*time;
        if(vec1.z<8){
            vec1.z=8;
            vec2.z=8;
            vec3.z=8;
            vec4.z=8;
        }
        if(vec1.z>24){
            vec1.z=24;
            vec2.z=24;
            vec3.z=24;
            vec4.z=24;
        }
        if(vec1.x<(-3)){
            vec1.x = -3;
            vec2.x = -3+width;
            vec3.x = -3+width;
            vec4.x = -3;
        }

        if(vec3.x>(3)){
            vec1.x = 3-width;
            vec2.x = 3;
            vec3.x = 3;
            vec4.x = 3-width;
        }
        
        if(vec1.y<=(-2)){
            vec1.y = -2;
            vec2.y = -2;
            vec3.y = -2+width;
            vec4.y = -2+width;
        }
        
        if(vec3.y>=(2)){
            vec1.y = 2-width;
            vec2.y = 2-width;
            vec3.y = 2;
            vec4.y = 2;
        }
        
    }
    
    
}
