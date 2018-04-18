//
//  Paddle.swift
//  CBSK
//
//  Created by Jamal Hashim on 10/2/15.
//  Copyright (c) 2015 Jamal Hashim. All rights reserved.
//



// four        three
//


//one         two
import UIKit
import SpriteKit

class Paddle: NSObject {
    var vec1:Vector;
    var vec2:Vector;
    var vec3:Vector;
    var vec4:Vector;
    var zLoc:Double
    var curve = 1.0
    var power = 1.0
    var pastLoc = [Vector](repeating: Vector(x: -0.75, y: -0.5, z: 0), count: 6)
    var price = 0
    init(z:Double){
        zLoc=z
        /*vec1=Vector(x:-0.75, y: -0.5, z: z);
        vec2=Vector(x: 0.75, y: -0.5, z: z);
        vec3=Vector(x:0.75, y: 0.5, z: z);
        vec4=Vector(x:-0.75, y: 0.5, z: z);*/
        
        vec1=Vector(x:-0.6, y: -0.4, z: z);
        vec2=Vector(x: 0.6, y: -0.4, z: z);
        vec3=Vector(x:0.6, y: 0.4, z: z);
        vec4=Vector(x:-0.6, y: 0.4, z: z);
        
    }
    
    func resetPoints(){
        pastLoc = [Vector](repeating: Vector(x: -0.6, y: -0.4, z: 0), count: 6)
    }
    func addPoint(){
        for index in 0...4{
            pastLoc[index]=pastLoc[index+1]
        }
        pastLoc[5]=vec1
    }
    
    func getCurveX()->Double{
        return (pastLoc[0].x-pastLoc[5].x)*27*curve
    }
    func getCurveY()->Double{
        return (pastLoc[0].y-pastLoc[5].y)*27*curve
    }
    
    func setLoc(_ one:Vector,three:Vector){
        vec1=one
        vec3=three
        vec2=Vector(x: three.x, y: one.y, z: one.z)
        vec4=Vector(x: one.x, y: three.y, z: one.z)
    }
    
    func midLoc()->Vector{
        return Vector(x: (vec1.x+vec3.x)/2, y: (vec1.y+vec3.y)/2, z: (vec1.z+vec3.z)/2)
    }
    func setMid(_ x:Double,y:Double){
        let width = (vec2.x-vec1.x)/2
        let height = (vec3.y-vec2.y)/2
        vec1 = Vector(x: x-width, y: y-height, z: zLoc)
        vec2 = Vector(x: x+width, y: y-height, z: zLoc)
        vec3 = Vector(x: x+width, y: y+height, z: zLoc)
        vec4 = Vector(x: x-width, y: y+height, z: zLoc)

    }
    func moveTo(_ speed:Double,loc:Vector){
        
        let midLoc:Vector = self.midLoc()
        let xDistance:Double = (loc.x-midLoc.x)
        let yDistance:Double = (loc.y-midLoc.y)
        let width = (vec2.x-vec1.x)/2
        let height = (vec3.y-vec2.y)/2

        
        
        var xRatio:Double = xDistance/(abs(xDistance)+abs(yDistance))
        var yRatio:Double = yDistance/(abs(xDistance)+abs(yDistance))
        if(xDistance==0&&yDistance==0){
            xRatio=0
            yRatio=0
        }
       // println("Vec1 x: " + String(stringInterpolationSegment: vec1.x))
       // println("xratio: "+String(stringInterpolationSegment: xRatio))
        
        if((abs(xDistance)<=abs(xRatio*speed))&&(abs(yDistance)<=abs(yRatio*speed))){
            
          //  println("Both")
                
               // return
            self.setLoc(Vector(x: loc.x-width, y: loc.y-height, z: vec1.z), three: Vector(x: loc.x+width, y: loc.y+height, z: vec3.z))
               // println(String(stringInterpolationSegment: loc.x-0.75))
                xRatio=0
                yRatio=0

            
        }

        else if(abs(xDistance)<=abs(xRatio*speed)){
           // println("x")
            xRatio=0
            setLoc(Vector(x: loc.x-width, y: vec1.y, z: vec1.z), three: Vector(x: loc.x+width, y: vec3.y, z: vec3.z))
        //    return
        }
        else if(abs(yDistance)<=abs(yRatio*speed)){
           // println("y")
            yRatio=0
            setLoc(Vector(x: vec1.x, y: loc.y-height, z: vec1.z), three: Vector(x: vec3.x, y: loc.y+height, z: vec3.z))
          //  return
        }
        
        vec1.x+=xRatio*speed
        vec2.x+=xRatio*speed
        vec3.x+=xRatio*speed
        vec4.x+=xRatio*speed
        
        vec1.y+=yRatio*speed
        vec2.y+=yRatio*speed
        vec3.y+=yRatio*speed
        vec4.y+=yRatio*speed
       
    }
    
    func paddleNode(_ screenx:Double,screeny:Double,zoom:Double,color:Int)->SKSpriteNode{
        
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
        if(color==0){
        rect = SKSpriteNode(imageNamed:"paddleblue")
        rect.zPosition=0.7
        }
        if(color==1){
        rect = SKSpriteNode(imageNamed:"paddlered")
        rect.zPosition = -1
        }
        let scalex = width/Double(rect.frame.width)
        let scaley = height/Double(rect.frame.height)
        rect.xScale=CGFloat(scalex)
        rect.yScale=CGFloat(scaley)
        rect.position=CGPoint(x:(x+x2)/2, y:(y+y2)/2)
        //rect.fillColor = SKColor.whiteColor()
        //rect.strokeColor=SKColor.blueColor()
        
        return rect

    }
    
    func setLoc(_ paddle:SKSpriteNode, screenx:Double,screeny:Double,zoom:Double){
        
        let halfWidth = paddle.frame.width/2
        let halfHeight = paddle.frame.height/2
        
        var x3d = ((Double((paddle.position.x-halfWidth))-screenx/2)*zLoc)/zoom
        var y3d = ((Double((paddle.position.y-halfHeight))-screeny/2)*zLoc)/zoom
        vec1=Vector( x: x3d , y: y3d ,  z: zLoc)
        
         x3d = ((Double((paddle.position.x+halfWidth))-screenx/2)*zLoc)/zoom
         y3d = ((Double((paddle.position.y-halfHeight))-screeny/2)*zLoc)/zoom
        vec2=Vector( x: x3d , y: y3d ,  z: zLoc)
        
         x3d = ((Double((paddle.position.x+halfWidth))-screenx/2)*zLoc)/zoom
         y3d = ((Double((paddle.position.y+halfHeight))-screeny/2)*zLoc)/zoom
        vec3=Vector( x: x3d , y: y3d ,  z: zLoc)
        
         x3d = ((Double((paddle.position.x-halfWidth))-screenx/2)*zLoc)/zoom
         y3d = ((Double((paddle.position.y+halfHeight))-screeny/2)*zLoc)/zoom
        vec4=Vector( x: x3d , y: y3d ,  z: zLoc)
        
        
        
    }
    
    
    
    func printVectors(){
        /*println("vec1: "+String(stringInterpolationSegment: vec1.x)+" "+String(stringInterpolationSegment: vec1.y))
        println("vec2: "+String(stringInterpolationSegment: vec2.x)+" "+String(stringInterpolationSegment: vec2.y))
        println("vec3: "+String(stringInterpolationSegment: vec3.x)+" "+String(stringInterpolationSegment: vec3.y))
        println("vec4: "+String(stringInterpolationSegment: vec4.x)+" "+String(stringInterpolationSegment: vec4.y))*/
    }
    
}
