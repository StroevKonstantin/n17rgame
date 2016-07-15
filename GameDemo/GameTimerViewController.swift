//
//  GameTimerViewController.swift
//  GameDemo
//
//  Created by Altynai Orynbayeva on 7/8/16.
//  Copyright © 2016 Altynai Orynbaeva. All rights reserved.
//

import UIKit
import SpriteKit
import RealmSwift

class GameTimerViewController: UIViewController {
    
    @IBOutlet weak var taskLbl: UILabel!
    
    var storage:Storage = Storage.sharedInstance
    
    var arrayIndexes:[Int] = []
    var index:Int = 0
    var indexW:Int = 0
    var filteredWords:[Word] = []
    
    let timeLeftShapeLayer = CAShapeLayer()
    let bgShapeLayer = CAShapeLayer()
    var timeLeft: NSTimeInterval = Double(Storage.sharedInstance.timeForAnswer)
    var endTime: NSDate!
    var timeLabel =  UILabel()
    var timer = NSTimer()
    
    // here you create your basic animation object to animate the strokeEnd
    let strokeIt = CABasicAnimation(keyPath: "strokeEnd")
    
    private var timerStartedAnimating = false
    
    func drawBgShape() {
        bgShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x:  view.frame.width/2 , y: 90.0), radius:
            50, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).CGPath
        bgShapeLayer.strokeColor = UIColor.whiteColor().CGColor
        bgShapeLayer.fillColor = UIColor.clearColor().CGColor
        bgShapeLayer.lineWidth = 8
        view.layer.addSublayer(bgShapeLayer)
    }
    
    func drawTimeLeftShape() {
        timeLeftShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.width/2 , y: 90.0), radius:
            50, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).CGPath
        timeLeftShapeLayer.strokeColor = UIColor(red: 255.0/255.0, green: 169.0/255.0, blue: 0.0/255.0, alpha: 1).CGColor
        timeLeftShapeLayer.fillColor = UIColor.clearColor().CGColor
        timeLeftShapeLayer.lineWidth = 8
        view.layer.addSublayer(timeLeftShapeLayer)
    }
    
    func addTimeLabel() {
        timeLabel = UILabel(frame: CGRectMake(view.frame.midX-50 , 65.0, 100, 50))
        timeLabel.textAlignment = .Center
        timeLabel.text = timeLeft.time
        view.addSubview(timeLabel)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        
        drawBgShape()
        drawTimeLeftShape()
        addTimeLabel()
        
        filterWordsByCategory()
        generateRandomSequence()
        nextWord()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if timerStartedAnimating { return }
        timerStartedAnimating = true
        
        // here you define the fromValue, toValue and duration of your animation
        strokeIt.fromValue = 0.0
        strokeIt.toValue = 1.0
        strokeIt.duration =  Double(storage.timeForAnswer)
        // add the animation to your timeLeftShapeLayer
        
        timeLeftShapeLayer.addAnimation(strokeIt, forKey: nil)
        // define the future end time by adding the timeLeft to now NSDate()
        endTime = NSDate().dateByAddingTimeInterval(timeLeft)
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(GameTimerViewController.updateTime), userInfo: nil, repeats: true)
    }
    
    func updateTime() {
        if timeLeft > 0 {
            timeLeft = endTime.timeIntervalSinceNow
            timeLabel.text = timeLeft.time
        } else {
            timeLabel.text = "00:00"
            timer.invalidate()
            
            for team in storage.activeTeams {
                if team.isMove == true {
                    team.isChangeCategory = false
                }
            }
            
            finishRoundForOneTeam()
        }
    }
    
    @IBAction func wrongAnswerBtnPrssd(sender: AnyObject) {
        nextWord()
        
        for team in storage.activeTeams {
            if team.isMove == true {
                team.isChangeCategory = false
            }
        }
    }
    
    @IBAction func rightAnswerBtnPrssed(sender: AnyObject) {
        let realm = try! Realm()
        let currentCategoryPoints = realm.objects(Category.self).filter("id = %@", storage.currentCategory).first?.points

        for team in storage.activeTeams {
            if team.isMove == true {
                team.result += currentCategoryPoints!
                team.isChangeCategory = true
            }
        }
        nextWord()
    }
    
    func generateRandomSequence(){
        let count = filteredWords.count
        
        for x in 0 ..< count*10 {
            let rand = Int(arc4random_uniform(UInt32(count)))
            if !arrayIndexes.contains(rand){
                arrayIndexes.append(rand)
            }
        }
    }
    
    func filterWordsByCategory(){
        for item in storage.tasks {
//            print("\(storage.currentCategory) || \(item.category!.id)")
            if item.category?.id == storage.currentCategory {
                filteredWords.append(item)
            }
        }
//        print(filteredWords)
    }
    
    func nextWord(){
        
        if index < 3 {
            taskLbl.text = filteredWords[arrayIndexes[index]].word
            index += 1
        } else {
            finishRoundForOneTeam()
        }
    }
    
    func finishRoundForOneTeam(){
        for team in storage.activeTeams {
            if team.isMove == true {
                print(team.result)
            }
        }
        
        startRoundForNextTeam()
        
        self.view.window!.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    func startRoundForNextTeam() {
        
        for team in storage.activeTeams {
            if team.isMove == true {
                indexW = storage.activeTeams.indexOf(team)!
                team.isMove = false
            }
        }

        indexW += 1
        
        if indexW <= storage.activeTeams.count-1 {
            storage.activeTeams[indexW].isMove = true
        } else {
            storage.numberOFRound += 1
            indexW = 0
            
            for team in storage.activeTeams {
                team.isMove = false
            }
            
            storage.activeTeams.first?.isMove = true
        }

//        print(storage.activeTeams)
    }
    
    @IBAction func closeButtonPressed(sender: UIButton) {
        let seconds:Double = Double(timeLeft)
        let state:Double = seconds/Double(storage.timeForAnswer)
        
        timeLabel.text = timeLeft.time
        timer.invalidate()

        
        strokeIt.fromValue = 1.0 - state
        strokeIt.toValue = 1.0 - state
        timeLeftShapeLayer.addAnimation(strokeIt, forKey: nil)
        
        let alert = UIAlertController(title: "ОСТАНОВИТЬ ИГРУ",
                                      message: " Вы желаете прекратить игру ",
                                      preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Главное меню", style: UIAlertActionStyle.Default, handler: { action in self.setupGame()}))
        alert.addAction(UIAlertAction(title: "Продолжить", style: UIAlertActionStyle.Default, handler: {action in self.continueGame()}))
        presentViewController(alert, animated: true, completion:nil)
    }
    
    func setupGame(){
//        let f:HomeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController;
//        self.navigationController?.pushViewController(f, animated: true)
    }
    
    func continueGame(){

        
        let seconds:Double = Double(timeLeft)
        let state:Double = seconds/Double(storage.timeForAnswer)
        
        strokeIt.fromValue = 1.0 - state
        strokeIt.toValue = 1.0
        strokeIt.duration =  seconds
        
        timeLeftShapeLayer.addAnimation(strokeIt, forKey: nil)
        
        endTime = NSDate().dateByAddingTimeInterval(timeLeft)
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(GameTimerViewController.updateTime), userInfo: nil, repeats: true)
    }
    
}


extension Double {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * CGFloat(M_PI) / 180.0
    }
}

extension NSTimeInterval {
    var time:String {
        return String(format:"%02d:%02d", Int(self/60.0),  Int(ceil(self%60)) )
    }
}

