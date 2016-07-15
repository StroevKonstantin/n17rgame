//
//  HomeViewController.swift
//  GameDemo
//
//  Created by Altynai Orynbayeva on 7/5/16.
//  Copyright © 2016 Altynai Orynbaeva. All rights reserved.
//


import UIKit
import SwiftyJSON
import RealmSwift

class HomeViewController: UIViewController {

    @IBOutlet weak var rulesButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var startGameButton: UIButton!
    
    var popViewController : PopUpViewControllerSwift!
    
    var storage:Storage = Storage.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let isFirstLaunch = NSUserDefaults.standardUserDefaults().objectForKey("isFirstLaunch") {
            print("Not first launch")
            
        } else {
            print("First launch")
            
            fillDatabaseCategories()
            fillDatabaseWords()
            
            NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "isFirstLaunch")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        readFromDatabase()
    }
    
    func fillDatabaseCategories() {
        
        if let path = NSBundle.mainBundle().pathForResource("categories", ofType: "json") {
            if let data = NSData(contentsOfFile: path) {
                let json = JSON(data: data, options: NSJSONReadingOptions.AllowFragments, error: nil)
                
                let realm = try! Realm()
                
                if let items = json.array {
                    for item in items {
                        
                        let newCategory = Category()
                        
                        newCategory.id = item["id"].int!
                        newCategory.name = item["name"].string!
                        newCategory.annotation = item["annotation"].string!
                        newCategory.points = item["points"].int!
                        
                        try! realm.write {
                            realm.add(newCategory)
                        }
                    }
                }
//                print(Realm.Configuration.defaultConfiguration.fileURL)
//                print(realm.objects(Category.self).filter("points < 6"))
                
            }
        }
    }
    
    func fillDatabaseWords(){
        
        if let path = NSBundle.mainBundle().pathForResource("words", ofType: "json") {
            if let data = NSData(contentsOfFile: path) {
                let json = JSON(data: data, options: NSJSONReadingOptions.AllowFragments, error: nil)
                
                let realm = try! Realm()
                
                if let items = json.array {
                    for item in items {
                        
                        let word = Word()
                        
                        let currentCategory = realm.objects(Category.self).filter("id = %@", item["category_id"].int!)
                        
                        word.word = item["word"].string!
                        word.category = currentCategory.first
                        
                        try! realm.write {
                            realm.add(word)
                        }
                    }
                }
//                print(Realm.Configuration.defaultConfiguration.fileURL)
                print(realm.objects(Word.self))
                
            }
        }
    }
    
    func readFromDatabase(){
        
        let wordsArray = try! Realm().objects(Word.self)
        for item in wordsArray {
            storage.tasks.append(item)
        }
        
        print(storage.tasks)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func settingsButtonPressed(sender: AnyObject) {
        let bundle = NSBundle(forClass: PopUpViewControllerSwift.self)
        
        if (UIDevice.currentDevice().userInterfaceIdiom == .Pad)
        {
            self.popViewController = PopUpViewControllerSwift(nibName: "PopUpViewController_iPad", bundle: bundle)
            self.popViewController.title = "This is a popup view"
            self.popViewController.showInView(self.view, animated: true)
        } else
        {
            if UIScreen.mainScreen().bounds.size.width > 320 {
                if UIScreen.mainScreen().scale == 3 {
                    self.popViewController = PopUpViewControllerSwift(nibName: "PopUpViewController_iPhone6Plus", bundle: bundle)
                    self.popViewController.title = "This is a popup view"
                    self.popViewController.showInView(self.view, animated: true)
                } else {
                    self.popViewController = PopUpViewControllerSwift(nibName: "PopUpViewController_iPhone6", bundle: bundle)
                    self.popViewController.title = "This is a popup view"
                    self.popViewController.showInView(self.view, animated: true)
                }
            } else {
                self.popViewController = PopUpViewControllerSwift(nibName: "PopUpViewController", bundle: bundle)
                self.popViewController.title = "This is a popup view"
                self.popViewController.showInView(self.view, animated: true)
            }
        }
    }
    
    @IBAction func rulesButtonPressed(sender: UIButton) {
        let r:RulesViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RulesViewController") as! RulesViewController;
        
        self.navigationController?.pushViewController(r, animated: true)
    }
    
    @IBAction func startGameButtonPressed(sender: UIButton) {
        let f:ChooseTeamViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ChooseTeamViewController") as! ChooseTeamViewController;
        
        self.navigationController?.pushViewController(f, animated: true)
        
    }
    
    
    
//    func setRoundedBorder(radius : CGFloat, withBorderWidth borderWidth: CGFloat, withColor color : UIColor, forButton button : UIButton) {
//        let l : CALayer = button.layer
//        l.masksToBounds = true
//        l.cornerRadius = radius
//        l.borderWidth = borderWidth
//        l.borderColor = color.CGColor
//    }


}
