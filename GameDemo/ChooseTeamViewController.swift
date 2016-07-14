//
//  ChooseTeamViewController.swift
//  GameDemo
//
//  Created by Altynai Orynbayeva on 7/7/16.
//  Copyright © 2016 Altynai Orynbaeva. All rights reserved.
//

import UIKit

class ChooseTeamViewController: UIViewController {

    var storage:Storage = Storage.sharedInstance
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        let side:CGFloat = 60
        let size:CGFloat = 140
        
        let x = (self.view.frame.width - size) / 2
        let y = (self.view.frame.height - (size/2)) / 2
        
        // star button
        let starButton = DOFavoriteButton(frame: CGRectMake(x-side, y-side, size, size), image: UIImage(named: "star"))
        starButton.tag = 1
        starButton.addTarget(self, action: #selector(ChooseTeamViewController.tappedButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(starButton)
        
        // heart button
        let heartButton = DOFavoriteButton(frame: CGRectMake(x+side, y-side, size, size), image: UIImage(named: "heart"))
        heartButton.tag = 2
        heartButton.imageColorOn = UIColor(red: 254/255, green: 110/255, blue: 111/255, alpha: 1.0)
        heartButton.circleColor = UIColor(red: 254/255, green: 110/255, blue: 111/255, alpha: 1.0)
        heartButton.lineColor = UIColor(red: 226/255, green: 96/255, blue: 96/255, alpha: 1.0)
        heartButton.addTarget(self, action: #selector(ChooseTeamViewController.tappedButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(heartButton)
        
        // like button
        let likeButton = DOFavoriteButton(frame: CGRectMake(x-side, y+side, size, size), image: UIImage(named: "like"))
        likeButton.tag = 3
        likeButton.imageColorOn = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
        likeButton.circleColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
        likeButton.lineColor = UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1.0)
        likeButton.addTarget(self, action: #selector(ChooseTeamViewController.tappedButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(likeButton)
        
        // smile button
        let smileButton = DOFavoriteButton(frame: CGRectMake(x+side, y+side, size, size), image: UIImage(named: "smile"))
        smileButton.tag = 4
        smileButton.imageColorOn = UIColor(red: 45/255, green: 204/255, blue: 112/255, alpha: 1.0)
        smileButton.circleColor = UIColor(red: 45/255, green: 204/255, blue: 112/255, alpha: 1.0)
        smileButton.lineColor = UIColor(red: 45/255, green: 195/255, blue: 106/255, alpha: 1.0)
        smileButton.addTarget(self, action: #selector(ChooseTeamViewController.tappedButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(smileButton)
        
        //other button
       /* let smileButton = DOFavoriteButton(frame: CGRectMake(x, y, 44, 44), image: UIImage(named: "smile"))
        smileButton.imageColorOn = UIColor(red: 45/255, green: 204/255, blue: 112/255, alpha: 1.0)
        smileButton.circleColor = UIColor(red: 45/255, green: 204/255, blue: 112/255, alpha: 1.0)
        smileButton.lineColor = UIColor(red: 45/255, green: 195/255, blue: 106/255, alpha: 1.0)
        smileButton.addTarget(self, action: #selector(ChooseTeamViewController.tappedButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(smileButton)
        */
    }
 
    func tappedButton(sender: DOFavoriteButton) {
        if sender.selected {
            sender.deselect()
            print("Team deselected \(sender.tag)")
            
            
        } else {
            sender.select()
            print("Team selected \(sender.tag)")
            
            let newTeam = Team()
            newTeam.team_id = sender.tag
            storage.activeTeams.append(newTeam)
            
        }
        
    }
    
    @IBAction func goToTapped(sender: UIButton) {        
        let s:ShakeMeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ShakeMeViewController") as! ShakeMeViewController;
        
        self.navigationController?.pushViewController(s, animated: true)
        
    }
   
}
