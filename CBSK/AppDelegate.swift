
//
//  AppDelegate.swift
//  CBSK
//
//  Created by Jamal Hashim on 9/29/15.
//  Copyright (c) 2015 Jamal Hashim. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths[0] 
        
        let filePath =  (documentDirectory as NSString).appendingPathComponent("CBSKData3.plist")
        //print(NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? String)
        if let gameData = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? GameData {
            //println(gameData.gems)
            //print(gameData.scoreHard)
            variables.highLevel = gameData.level
            variables.highScore = gameData.score
            if(gameData.paddle == 1){
                variables.paddle=Paddle(z: 8)
            }
            if(gameData.paddle == 2){
                variables.paddle=CrossPaddle(z: 8)
            }
            if(gameData.paddle == 3){
                variables.paddle=FractalPaddle(z: 8)
            }
            if(gameData.paddle == 4){
                variables.paddle=InfinityPaddle(z: 8)
            }
            if(gameData.paddle == 5){
                variables.paddle=MustachePaddle(z: 8)
            }
            if(gameData.paddle == 6){
                variables.paddle=SkullPaddle(z: 8)
            }
            variables.gems = gameData.gems
            variables.skull = gameData.skull
            variables.fractal = gameData.fractal
            variables.infinity = gameData.infinity
            variables.mustache = gameData.mustache
            variables.cross = gameData.cross
            variables.highScoreHard=gameData.scoreHard
  //          variables.cross=false
//            variables.gems=7000

            
        }
        else{
           
            
            let gameData = GameData(gems: 0, level: 0, score: 0, paddle: 1, skull: false, fractal: false, infinity: false, mustache: false, ultimate: false, cross: false, scoreHard: 0)
            NSKeyedArchiver.archiveRootObject(gameData, toFile: filePath)
            
        }
    
        //sleep(1)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
        //println("inactive")
        variables.background = true
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        variables.background = true
        //println("background")
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        //println("inactive")
        
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {

        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        //println("callsed")
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths[0] 
        let filePath =  (documentDirectory as NSString).appendingPathComponent("CBSKData3.plist")
        //println(variables.gems)
        var gameData:GameData
        
        gameData = GameData(gems: variables.gems, level: variables.highLevel, score: variables.highScore, paddle: Data.getPaddle(), skull: variables.skull, fractal: variables.fractal, infinity: variables.infinity, mustache: variables.mustache, ultimate: variables.ultimate, cross: variables.cross, scoreHard: variables.highScoreHard)
        NSKeyedArchiver.archiveRootObject(gameData, toFile: filePath)


    }


}

