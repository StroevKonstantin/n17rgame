//
//  PageContentViewController.swift
//  GameDemo
//
//  Created by Altynai Orynbayeva on 7/12/16.
//  Copyright © 2016 Altynai Orynbaeva. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {
    var pageIndex: Int!
    var titleText: String!
    var imageFile: String!

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.imageView.image = UIImage(named: imageFile)
        self.lblTitle.text = self.titleText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
