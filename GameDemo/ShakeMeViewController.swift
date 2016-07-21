//
//  ShakeMeViewController.swift
//  GameDemo
//
//  Created by Altynai Orynbayeva on 7/7/16.
//  Copyright © 2016 Altynai Orynbaeva. All rights reserved.
//

import UIKit
import CoreMotion
import RealmSwift

class ShakeMeViewController: UIViewController {
    
    @IBOutlet weak var teamMoveLbl: UILabel!
    
    var storage:Storage = Storage.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    lazy var motionManager: CMMotionManager = {
        return CMMotionManager()
    }()
    
    let accelerationThreshold = 2.5
    
    var handlingShake = false
    
    override func viewWillAppear(animated: Bool) {
        makeMove()
        getRandomCategory()
//        showResult()
        
        handlingShake = false
        motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.currentQueue()!) { [weak self] (motion, error) in
            if
                let userAcceleration = motion?.userAcceleration,
                let _self = self {
                
//                print("\(userAcceleration.x) / \(userAcceleration.y)")
                
                if (fabs(userAcceleration.x) > _self.accelerationThreshold
                    || fabs(userAcceleration.y) > _self.accelerationThreshold
                    || fabs(userAcceleration.z) > _self.accelerationThreshold)
                {
                    if !_self.handlingShake {
                        _self.handlingShake = true
                        _self.handleShake();
                    }
                }
                
            } else {
                print("Motion error: \(error)")
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        // or wherever appropriate
        motionManager.stopDeviceMotionUpdates()
        
    }
    
    func handleShake() {
        //performSegueWithIdentifier("showShakeScreen", sender: nil)
        let f:TaskViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TaskViewController") as! TaskViewController;
        
//        self.presentViewController(f, animated: true, completion: nil)
        self.navigationController?.pushViewController(f, animated: true)

 
    }
    
    func getRandomCategory(){
        storage.currentCategory = Int(arc4random_uniform(UInt32(2))+1)
        print("=======================")
        print(storage.currentCategory)
    }
    
    func makeMove(){
        for team in storage.activeTeams {
            if team.isMove == true {
                teamMoveLbl.text = "... команды \(team.team_id)"
            }
        }
    }

    func showResult(){
        var resultString:String = ""
        
        for team in storage.activeTeams {
            resultString = resultString + "\(team.team_id)/ \(team.result); "
        }
        
//        resultsLbl.text = resultString
    }
    
}
