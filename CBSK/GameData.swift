//
//  GameData.swift
//  CBSK
//
//  Created by Jamal Hashim on 11/12/15.
//  Copyright (c) 2015 Jamal Hashim. All rights reserved.
//
import UIKit

class GameData: NSObject, NSCoding {
    var level: Int
    var score: Int
    var paddle:Int
    var gems:Int
    var skull:Bool
    var fractal:Bool
    var infinity:Bool
    var mustache:Bool
    var ultimate:Bool
    var cross:Bool
    var scoreHard:Int
    
    init(gems:Int, level:Int, score:Int, paddle:Int, skull:Bool, fractal:Bool, infinity:Bool, mustache:Bool, ultimate:Bool, cross:Bool, scoreHard:Int) {
        self.level = level
        self.score = score
        self.paddle = paddle
        self.gems = gems
        self.skull = skull
        self.fractal = fractal
        self.infinity = infinity
        self.mustache = mustache
        self.cross = cross
        self.ultimate=ultimate
        self.scoreHard=scoreHard
    }

    
    // MARK: NSCoding
    required convenience init?(coder decoder: NSCoder) {
        
        let level = decoder.decodeCInt(forKey: "level")
        let score = decoder.decodeCInt(forKey: "score")
        let paddle = decoder.decodeCInt(forKey: "paddle")
        let gems = decoder.decodeCInt(forKey: "gems")
        let skull = decoder.decodeBool(forKey: "skull")
        let fractal = decoder.decodeBool(forKey: "fractal")
        let infinity = decoder.decodeBool(forKey: "infinity")
        let mustache = decoder.decodeBool(forKey: "mustache")
        let cross = decoder.decodeBool(forKey: "cross")
        let scoreHard = decoder.decodeCInt(forKey: "hardscore");
        
        self.init(gems: Int(gems),level:Int(level),score:Int(score),paddle:Int(paddle),skull:skull,fractal:fractal,infinity:infinity,mustache:mustache,ultimate:false,cross:cross,scoreHard:Int(scoreHard))
    }
    
    func encode(with coder: NSCoder) {
        coder.encodeCInt(Int32(self.level), forKey: "level")
        coder.encodeCInt(Int32(self.score), forKey: "score")
        coder.encodeCInt(Int32(self.paddle), forKey: "paddle")
        coder.encodeCInt(Int32(self.gems), forKey: "gems")
        coder.encode(self.skull, forKey: "skull")
        coder.encode(self.cross, forKey: "cross")
        coder.encode(self.fractal, forKey: "fractal")
        coder.encode(self.infinity, forKey: "infinity")
        coder.encode(self.mustache, forKey: "mustache")
        coder.encodeCInt(Int32(self.scoreHard), forKey: "hardscore")
    }
}
