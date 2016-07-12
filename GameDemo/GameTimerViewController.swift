//
//  GameTimerViewController.swift
//  GameDemo
//
//  Created by Altynai Orynbayeva on 7/8/16.
//  Copyright © 2016 Altynai Orynbaeva. All rights reserved.
//

import UIKit
import SpriteKit
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

class GameTimerViewController: UIViewController {
    
    let timeLeftShapeLayer = CAShapeLayer()
    let bgShapeLayer = CAShapeLayer()
    var timeLeft: NSTimeInterval = 60.0
    var endTime: NSDate!
    var timeLabel =  UILabel()
    var timer = NSTimer()
    // here you create your basic animation object to animate the strokeEnd
    let strokeIt = CABasicAnimation(keyPath: "strokeEnd")
    
    func drawBgShape() {
        bgShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x:  view.frame.width/2 , y: 90.0), radius:
            50, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).CGPath
        bgShapeLayer.strokeColor = UIColor.whiteColor().CGColor
        bgShapeLayer.fillColor = UIColor.clearColor().CGColor
        bgShapeLayer.lineWidth = 15
        view.layer.addSublayer(bgShapeLayer)
    }
    func drawTimeLeftShape() {
        timeLeftShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.width/2 , y: 90.0), radius:
            50, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).CGPath
        timeLeftShapeLayer.strokeColor = UIColor.redColor().CGColor
        timeLeftShapeLayer.fillColor = UIColor.clearColor().CGColor
        timeLeftShapeLayer.lineWidth = 15
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

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor(white: 0.94, alpha: 1.0)
        
        drawBgShape()
        drawTimeLeftShape()
        addTimeLabel()
        
        // here you define the fromValue, toValue and duration of your animation
        strokeIt.fromValue = 0.0
        strokeIt.toValue = 1.0
        strokeIt.duration = 60.0
        // add the animation to your timeLeftShapeLayer
        
        timeLeftShapeLayer.addAnimation(strokeIt, forKey: nil)
        // define the future end time by adding the timeLeft to now NSDate()
        endTime = NSDate().dateByAddingTimeInterval(timeLeft)
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(GameTimerViewController.updateTime), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func updateTime() {
        if timeLeft > 0 {
            timeLeft = endTime.timeIntervalSinceNow
            timeLabel.text = timeLeft.time
        } else {
            timeLabel.text = "00:00"
            timer.invalidate()
        }

    }
    
}

