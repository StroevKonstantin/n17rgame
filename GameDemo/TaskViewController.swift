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
    
    @IBOutlet weak var categoryTaskLbl: UILabel!
    @IBOutlet weak var taskDescriptionLbl: UILabel!
    
    var storage:Storage = Storage.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showCategoryInfo()
        
    }
    
    func showCategoryInfo(){
        let realm = try! Realm()
        
        let currentCategory = realm.objects(Category.self).filter("id = %@", storage.currentCategory)
        
        categoryTaskLbl.text = currentCategory.first?.name
        taskDescriptionLbl.text = currentCategory.first?.annotation
    }

    @IBAction func startButtonPressed(sender: UIButton) {
        
        let f:GameTimerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("GameTimerViewController") as! GameTimerViewController;
        
        
        self.presentViewController(f, animated: true, completion: nil)
    }
    
}
