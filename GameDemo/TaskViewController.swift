//
//  TaskViewController.swift
//  GameDemo
//
//  Created by Altynai Orynbayeva on 7/7/16.
//  Copyright © 2016 Altynai Orynbaeva. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class TaskViewController: UIViewController {
    
    let str = " "
    @IBOutlet weak var categoryTaskLbl: UILabel!
    @IBOutlet weak var taskDescriptionLbl: UILabel!

    @IBAction func startButtonPressed(sender: UIButton) {
        
        let f:GameTimerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("GameTimerViewController") as! GameTimerViewController;
        
        self.presentViewController(f, animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

  
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
   

}
