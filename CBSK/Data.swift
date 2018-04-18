//
//  Data.swift
//  CBSK
//
//  Created by Jamal Hashim on 10/23/15.
//  Copyright (c) 2015 Jamal Hashim. All rights reserved.
//

import UIKit
public var level = 0
class Data: NSObject {
    static func getPaddle()->Int{
        if(variables.paddle is SkullPaddle){
            return 6
        }
        if(variables.paddle is MustachePaddle){
            return 5
        }
        if(variables.paddle is InfinityPaddle){
            return 4
        }
        if(variables.paddle is FractalPaddle){
            return 3
        }
        if(variables.paddle is CrossPaddle){
            return 2
        }
        return 1
    }
}
struct variables {
    
    static var level: Int = 0
    static var score = 0
    static var scoreHard = 0
    static var paddle = Paddle(z: 8)
    static var gems = 0
    static var skull = false
    static var fractal = false
    static var infinity = false
    static var mustache = false
    static var ultimate = false
    static var cross = false
    static var highScore = 0;
    static var highScoreHard=0;
    static var highLevel = 0;
    static var GCEnabled = false
    static var background = false
}
