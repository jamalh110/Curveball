//
//  MatchData.swift
//  Curveball
//
//  Created by Jamal Hashim on 12/22/15.
//  Copyright (c) 2015 Jamal Hashim. All rights reserved.
//

import UIKit

class MatchData: NSObject, NSCoding {
    var padx:Float
    var pady:Float
    var gameOver:Bool
    var ballx:Float
    var bally:Float
    var ballz:Float
    var ballEdge:Bool
    var response:Int
    var red:Bool
    var ballSpeed:Double
    var ballCurveX:Double
    var ballCurveY:Double
    var hostLives:Int
    var clientLives:Int
    var ballxSpeed:Double
    var ballySpeed:Double
    var padCurveX:Double
    var padCurveY:Double
    
    init(padx:Float,pady:Float,gameOver:Bool,ballx:Float,bally:Float,ballz:Float,ballEdge:Bool,response:Int, red:Bool, ballSpeed:Double,ballCurveX:Double,ballCurveY:Double,hostLives:Int,clientLives:Int,ballxSpeed:Double,ballySpeed:Double,padCurveX:Double,padCurveY:Double){
        self.padx = padx
        self.pady = pady
        self.gameOver=gameOver
        self.ballx=ballx
        self.bally=bally
        self.ballz=ballz
        self.ballEdge=ballEdge
        self.response=response
        self.red=red
        self.ballSpeed=ballSpeed
        self.ballCurveX=ballCurveX
        self.ballCurveY=ballCurveY
        self.hostLives = hostLives
        self.clientLives = clientLives
        self.ballxSpeed = ballxSpeed
        self.ballySpeed = ballySpeed
        self.padCurveX = padCurveX
        self.padCurveY = padCurveY
        
    }
    required convenience init?(coder decoder: NSCoder) {
        
        let padx = decoder.decodeFloat(forKey: "padx")
        let pady = decoder.decodeFloat(forKey: "pady")
        let gameOver = decoder.decodeBool(forKey: "gameover")
        let ballx = decoder.decodeFloat(forKey: "ballx")
        let bally = decoder.decodeFloat(forKey: "bally")
        let ballz = decoder.decodeFloat(forKey: "ballz")
        let ballEdge = decoder.decodeBool(forKey: "ballEdge")
        let response = decoder.decodeCInt(forKey: "response")
        let red = decoder.decodeBool(forKey: "red")
        let ballSpeed = decoder.decodeDouble(forKey: "ballSpeed")
        let ballCurveX = decoder.decodeDouble(forKey: "ballCurveX")
        let ballCurveY = decoder.decodeDouble(forKey: "ballCurveY")
        let hostLives = decoder.decodeCInt(forKey: "hostLives")
        let clientLives = decoder.decodeCInt(forKey: "clientLives")
        let ballxSpeed = decoder.decodeDouble(forKey: "ballxSpeed")
        let ballySpeed = decoder.decodeDouble(forKey: "ballySpeed")
        let padCurveX = decoder.decodeDouble(forKey: "padCurveX")
        let padCurveY = decoder.decodeDouble(forKey: "padCurveY")
        self.init(padx:padx,pady:pady,gameOver:gameOver,ballx:ballx,bally:bally,ballz:ballz,ballEdge:ballEdge,response:Int(response),red:red,ballSpeed:ballSpeed,ballCurveX:ballCurveX,ballCurveY:ballCurveY,hostLives:Int(hostLives),clientLives:Int(clientLives),ballxSpeed:ballxSpeed,ballySpeed:ballySpeed,padCurveX:padCurveX,padCurveY:padCurveY)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.padx, forKey: "padx")
        coder.encode(self.pady, forKey: "pady")
        coder.encode(self.gameOver, forKey: "gameover")
        coder.encode(self.ballx, forKey: "ballx")
        coder.encode(self.bally, forKey: "bally")
        coder.encode(self.ballz, forKey: "ballz")
        coder.encode(self.ballEdge, forKey: "ballEdge")
        coder.encode(self.response, forKey: "response")
        coder.encode(self.red, forKey: "red")
        coder.encode(self.ballSpeed, forKey: "ballSpeed")
        coder.encode(self.ballCurveX, forKey: "ballCurveX")
        coder.encode(self.ballCurveY, forKey: "ballCurveY")
        coder.encode(self.hostLives, forKey: "hostLives")
        coder.encode(self.clientLives, forKey: "clientLives")
        coder.encode(self.ballxSpeed, forKey: "ballxSpeed")
        coder.encode(self.ballySpeed, forKey: "ballySpeed")
        coder.encode(self.padCurveX, forKey: "padCurveX")
        coder.encode(self.padCurveY, forKey: "padCurveY")
    }
}
