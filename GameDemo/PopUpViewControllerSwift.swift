//
//  PopUpViewControllerSwift.swift
//  NMPopUpView
//
//  Created by Nikos Maounis on 13/9/14.
//  Copyright (c) 2014 Nikos Maounis. All rights reserved.
//

import UIKit
import QuartzCore

@objc public class PopUpViewControllerSwift : UIViewController {
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    var storage:Storage = Storage.sharedInstance
   
    @IBAction func plusButtonPressed(sender: UIButton) {
        let longer = Int(messageLabel.text!)
        messageLabel.text = String(longer!+15)
        
    }
    
    @IBAction func minusButtonPressed(sender: UIButton) {
        let longer = Int(messageLabel.text!)
        if (longer > 0) {
            messageLabel.text = String(longer!-15)
        }
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func closeButtonTapped(sender: UIButton) {
        self.removeAnimate()
    }
    override public init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
       
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
        self.popUpView.layer.cornerRadius = 15
        self.popUpView.layer.shadowOpacity = 0.8
        self.popUpView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
    }
    
    public func showInView(aView: UIView!,animated: Bool)
    {
        aView.addSubview(self.view)
        
        if animated
        {
            self.showAnimate()
        }
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
        self.view.alpha = 0.0;
        UIView.animateWithDuration(0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animateWithDuration(0.25, animations: {
            self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }
    
    @IBAction public func closePopup(sender: AnyObject) {
        self.removeAnimate()
    }
}
