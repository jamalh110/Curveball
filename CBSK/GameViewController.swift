//
//  GameViewController.swift
//  SwiftReference
//
//  Created by Jamal Hashim on 10/21/15.
//  Copyright (c) 2015 Jamal Hashim. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit
import AVFoundation
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


extension SKNode {
    
}





class GameViewController: UIViewController, GKGameCenterControllerDelegate {
    var audioPlayer: AVAudioPlayer?
    func authenticateLocalPlayer()
    {
        let localPlayer = GKLocalPlayer.localPlayer()
        localPlayer.authenticateHandler = {(viewController : UIViewController?, error : Error?) -> Void in
            if(localPlayer.isAuthenticated){
                var allAchievements=[GKAchievement]()
                
                GKAchievement.loadAchievements(completionHandler: { (allAchievements, error:Error?) -> Void in
                    if(error==nil){
                        if let list = allAchievements {
                        for i in 0...list.count-1{
                       // for(var i=0;i<allAchievements?.count;i += 1){
                            if(allAchievements![i].identifier=="grp.cross"){
                               variables.cross=true
                            }
                            
                            if(allAchievements![i].identifier=="grp.fractal"){
                                variables.fractal=true
                            }
                            
                            if(allAchievements![i].identifier=="grp.infinite"){
                                variables.infinity=true
                            }
                            
                            if(allAchievements![i].identifier=="grp.mustache"){
                                variables.mustache=true
                            }
                            
                            if(allAchievements![i].identifier=="grp.skull"){
                                variables.skull=true
                            }
                        }
                    }
                    }
                    
                })
                
                
                var achievement = GKAchievement(identifier: "grp.cross")
               // print(achievement.percentComplete)
                if(variables.cross){
                    //print("yes")
                    achievement.percentComplete=100
                    achievement.showsCompletionBanner=true
                    GKAchievement.report([achievement], withCompletionHandler: nil)
                }
                
                 achievement = GKAchievement(identifier: "grp.fractal")
                if(variables.fractal){
                    achievement.percentComplete=100
                    achievement.showsCompletionBanner=true
                    GKAchievement.report([achievement], withCompletionHandler: nil)
                }
                
                 achievement = GKAchievement(identifier: "grp.infinite")
                if(variables.infinity){
                    achievement.percentComplete=100
                    achievement.showsCompletionBanner=true
                    GKAchievement.report([achievement], withCompletionHandler: nil)
                }
                
                 achievement = GKAchievement(identifier: "grp.mustache")
                if(variables.mustache){
                    achievement.percentComplete=100
                    achievement.showsCompletionBanner=true
                    GKAchievement.report([achievement], withCompletionHandler: nil)                }
                
                 achievement = GKAchievement(identifier: "grp.skull")
                if(variables.skull){
                    achievement.percentComplete=100
                    achievement.showsCompletionBanner=true
                    GKAchievement.report([achievement], withCompletionHandler: nil)
                }
            }
            if ((viewController) != nil) {
                self.present(viewController!, animated: true, completion: nil)
                //print("1")
            }else{
                //print("2")
                //println((GKLocalPlayer.localPlayer().authenticated))
            }
            } as! (UIViewController?, Error?) -> Void
    }
    
    func showLeaderboard()
    {
        let gcViewController: GKGameCenterViewController = GKGameCenterViewController()
        gcViewController.gameCenterDelegate = self
        
        gcViewController.viewState = GKGameCenterViewControllerState.leaderboards
        gcViewController.leaderboardIdentifier = "grp.curveballhighscore"
        
        self.present(gcViewController, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController)
    {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        
    }
    
    override var shouldAutorotate : Bool {
        return true
    }
    
    func testFunc(){
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        authenticateLocalPlayer()
        
        var isiphonex = false
        if UIDevice().userInterfaceIdiom == .phone {
            if UIScreen.main.nativeBounds.height == 2436{
                isiphonex=true
            }
        }
        
        let view = self.view!
        if(isiphonex){
            if #available(iOS 11.0, *) {
                print("ios11")
                //skView.frame = CGRect(x: skView.safeAreaLayoutGuide.layoutFrame.minX, y: skView.safeAreaLayoutGuide.layoutFrame.minY, width: skView.safeAreaLayoutGuide.layoutFrame.width, height: skView.safeAreaLayoutGuide.layoutFrame.height);
                //skView.bounds = CGRect(x: 39 , y: 0, width: 667, height: skView.safeAreaLayoutGuide.layoutFrame.height)
                
            } else {
                // Fallback on earlier versions
            }
            
            
            // self.view.frame = CGRect(x: 217, y: 0, width: 2002, height: 1125)
        }
        print("#1: " + (view.bounds.width).description)
        print(view.bounds.height)
        switch UIApplication.shared.statusBarOrientation {
        case .portrait:
            print("port")
            break
        case .portraitUpsideDown:
            print("port")
            //do something
            break
        case .landscapeLeft:
            print("land")
            //do something
            break
        case .landscapeRight:
            print("land")
            //do something
            break
        case .unknown:
            print("idk")
            //default
            break
        }
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.autoresizesSubviews=false;
        var skView2:SKView;
        if(isiphonex){
            skView2 = SKView(frame: CGRect(x: 72.5 , y: 0, width: 667, height: 375))
        }
        else{
            skView2 = SKView(frame: view.frame)
            
        }
        //self.view=skView2
        self.view.addSubview(skView2)
        print("ID" + ObjectIdentifier(view).debugDescription)
        let startScene = StartScene(size:skView2.bounds.size)
        print(startScene.anchorPoint.y)
        //startScene.mode
        if(isiphonex){
            //startScene.anchorPoint = CGPoint(x: 0.0892857, y: 0)
        }
        
        skView2.showsFPS = false
        skView2.showsNodeCount = false
        
        skView2.ignoresSiblingOrder = true
        startScene.scaleMode = .resizeFill
        
        skView2.presentScene(startScene)
        
        let aSound = URL(fileURLWithPath: Bundle.main.path(forResource: "Background", ofType: "m4a")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:aSound)
            audioPlayer!.numberOfLoops = -1
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
        } catch {
            print("Cannot play the file")
        }
        
        
        
        
        /* if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
         // Configure the view.
         let skView = self.view as! SKView
         skView.showsFPS = true
         skView.showsNodeCount = true
         
         /* Sprite Kit applies additional optimizations to improve rendering performance */
         skView.ignoresSiblingOrder = true
         
         /* Set the scale mode to scale to fit the window */
         scene.scaleMode = .AspectFill
         
         skView.presentScene(scene)
         }*/
    }
}
