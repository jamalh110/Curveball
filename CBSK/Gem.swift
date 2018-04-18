//
//  Gem.swift
//  CBSK
//
//  Created by Jamal Hashim on 11/4/15.
//  Copyright (c) 2015 Jamal Hashim. All rights reserved.
//

import UIKit
import SpriteKit
class Gem: NSObject {
    var vec1 = Vector(x: 0, y: 0, z: 0)
    var vec3 = Vector(x: 0, y: 0, z: 0)
    var vec1Mid = Vector(x: 0, y: 0, z: 0)
    var vec3Mid = Vector(x: 0, y: 0, z: 0)
    init(xMid: Double, yMid: Double, zMid:Double){
        vec1 = Vector(x: xMid-0.35, y: yMid-0.35, z:zMid-0.5)
        vec3 = Vector(x: xMid+0.35, y: yMid+0.35, z:zMid+0.5)
        vec1Mid = Vector(x: xMid-0.35, y: yMid-0.35, z:zMid)
        vec3Mid = Vector(x: xMid+0.35, y: yMid+0.35, z:zMid)
        
    }
    func gemNode(_ screenx:Double,screeny:Double,zoom:Double)->SKSpriteNode{
        
        let width:Double = (vec3Mid.convertToX(screenx, zoom:zoom)-vec1Mid.convertToX(screenx, zoom:zoom))
        let height:Double=(vec3Mid.convertToY(screeny, zoom:zoom)-vec1Mid.convertToY(screeny, zoom:zoom))
        let x = vec1Mid.convertToX(screenx, zoom: zoom)
        let y = vec1Mid.convertToY(screeny, zoom: zoom)
        let x2=vec3Mid.convertToX(screenx, zoom: zoom)
        let y2=vec3Mid.convertToY(screeny, zoom: zoom)
        // println(x)
        // println(y)
        // println(width)
        // println(height)
        let rect:SKSpriteNode = SKSpriteNode(imageNamed: "Gem")
        let scalex = width/Double(rect.frame.width)
        var scaley = height/Double(rect.frame.height)
        scaley = scalex
        rect.xScale=CGFloat(scalex)
        rect.yScale=CGFloat(scaley)
        rect.position=CGPoint(x:(x+x2)/2, y:(y+y2)/2)
        rect.zPosition = 0.1
        return rect
    }
    func inRange(_ ball: Ball)->Bool{
        if(!(ball.vec1.x>self.vec3.x||ball.vec3.x<self.vec1.x||ball.vec1.y>self.vec3.y||ball.vec3.y<self.vec1.y)){
            if((ball.vec1.z>self.vec1.z) && (ball.vec1.z<self.vec3.z)){
                return true
            }
        }
    return false
    
  }
}
