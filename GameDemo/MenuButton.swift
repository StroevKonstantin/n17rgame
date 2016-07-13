//
//  MenuButton.swift
//  GameDemo
//
//  Created by Konstantin S. Stroyev on 11.07.16.
//  Copyright © 2016 Altynai Orynbaeva. All rights reserved.
//

import UIKit

class MenuButton: UIButton {
        
    override func awakeFromNib() {
        layer.cornerRadius = 15
        layer.borderWidth = 3
        layer.borderColor = UIColor.whiteColor().CGColor
    }

}
