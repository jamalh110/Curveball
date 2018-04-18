//
//  Rect3D.swift
//  CBSK
//
//  Created by Jamal Hashim on 9/29/15.
//  Copyright (c) 2015 Jamal Hashim. All rights reserved.
//



// four        three
//


//one         two

import UIKit
import SpriteKit

class Rect3D: NSObject {
    //top corner one
    //back should be 0
    var vec1:Vector;
    var vec2:Vector;
    var vec3:Vector;
    var vec4:Vector;
  
    init(x:Double,y:Double,z:Double,width:Double,height:Double,back:Double){
        vec1=Vector(x: x, y:y, z: z)
        vec2=Vector(x: x+width, y:y, z: z)
        vec3=Vector(x: x+width, y:y+height, z: z)
        vec4=Vector(x: x, y:y+height, z: z)
     
    }
    
    func setZ(_ z:Double){
        vec1.z=z
        vec2.z=z
        vec3.z=z
        vec4.z=z
        
    }
    
    func rectNodeXY(_ screenx:Double,screeny:Double,zoom:Double)->SKShapeNode{
        let width:Double = (vec2.convertToX(screenx, zoom:zoom)-vec1.convertToX(screenx, zoom:zoom))
        let height:Double=(vec2.convertToY(screeny, zoom:zoom)-vec3.convertToY(screeny, zoom:zoom))
        
        let x:Double = (vec1.convertToX(screenx,zoom: zoom)+vec2.convertToX(screenx,zoom: zoom))/2
        let y:Double = (vec1.convertToY(screeny,zoom: zoom)+vec4.convertToY(screeny,zoom: zoom))/2
        let rect = SKShapeNode(rectOf: CGSize(width:width , height: height))
        rect.position=CGPoint(x:x, y:y)
        //rect.fillColor = SKColor.whiteColor()
        rect.strokeColor=SKColor.green
        rect.zPosition = -0.9
        
        return rect
        
    }
    
    
    func rectNodeXY(_ screenx:Double,screeny:Double,zoom:Double,color:SKColor)->SKShapeNode{
        let width:Double = (vec2.convertToX(screenx, zoom:zoom)-vec1.convertToX(screenx, zoom:zoom))
        let height:Double=(vec2.convertToY(screeny, zoom:zoom)-vec3.convertToY(screeny, zoom:zoom))
        
        let x:Double = (vec1.convertToX(screenx,zoom: zoom)+vec2.convertToX(screenx,zoom: zoom))/2
        let y:Double = (vec1.convertToY(screeny,zoom: zoom)+vec4.convertToY(screeny,zoom: zoom))/2
        let rect = SKShapeNode(rectOf: CGSize(width:width , height: height))
        rect.position=CGPoint(x:x, y:y)
        //rect.fillColor = SKColor.whiteColor()
        rect.strokeColor=color
        rect.zPosition = -0.9
        return rect
        
    }
    
}
