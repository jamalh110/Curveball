//
//  Vector.swift
//  CBSK
//
//  Created by Jamal Hashim on 9/29/15.
//  Copyright (c) 2015 Jamal Hashim. All rights reserved.
//


import UIKit
class Vector:NSObject {
    
    
    var x:Double
    var y:Double
    var z:Double
    
    init(x:Double,y:Double,z:Double){
        self.x=x
        self.y=y
        self.z=z
        
    }
    func convertToX(_ screenx:Double, zoom:Double)->Double{
        let factor = zoom/z
        return (x*factor+screenx/2)
        
    }
    
    func convertToY(_ screeny:Double, zoom:Double)->Double{
        
        let factor = zoom/z
        return (y*factor+screeny/2)
        
    }
    
    
}
