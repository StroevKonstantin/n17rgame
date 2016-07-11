//
//  NoButton.swift
//  GameDemo
//
//  Created by Konstantin S. Stroyev on 11.07.16.
//  Copyright © 2016 Altynai Orynbaeva. All rights reserved.
//

import UIKit

class NoButton: UIButton {

    override func awakeFromNib() {
        layer.cornerRadius = 60
        layer.borderWidth = 8
        layer.borderColor = RED_COLOR.CGColor
    }

}
