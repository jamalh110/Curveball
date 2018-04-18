//
//  Line3D.swift
//  CBSK
//
//  Created by Jamal Hashim on 10/1/15.
//  Copyright (c) 2015 Jamal Hashim. All rights reserved.
//

import UIKit
import SpriteKit
class Line3D: NSObject {
    
    var p1:Vector;
    var p2:Vector;
    
    init(x:Double,y:Double,z:Double,x2:Double,y2:Double,z2:Double){
        p1=Vector(x: x, y: y, z: z)
        p2=Vector(x: x2, y: y2, z: z2)
    }
    
    func lineNode(_ screenx:Double,screeny:Double,zoom:Double)->SKShapeNode{
        
        let x1:Double=p1.convertToX(screenx, zoom: zoom)
        let x2:Double=p2.convertToX(screenx, zoom: zoom)
        let y1:Double=p1.convertToY(screeny, zoom: zoom)
        let y2:Double=p2.convertToY(screeny, zoom: zoom)
        
        
        let line:SKShapeNode = SKShapeNode();
        let ref = CGMutablePath()
        
        ref.move(to: CGPoint(x: x1, y: y1))
        ref.addLine(to: CGPoint(x: x2, y: y2))
        //CGPathMoveToPoint(ref, nil, CGFloat(x1), CGFloat(y1))
        //CGPathAddLineToPoint(ref, nil, CGFloat(x2), CGFloat(y2));
        
        line.path = ref
        line.lineWidth = 1
        line.fillColor = UIColor.green
        line.strokeColor = UIColor.green
        line.zPosition = -0.9
        return line
        
    }
}
