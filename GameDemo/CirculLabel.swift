//
//  CirculLabel.swift
//  GameDemo
//
//  Created by Konstantin S. Stroyev on 11.07.16.
//  Copyright © 2016 Altynai Orynbaeva. All rights reserved.
//

import UIKit

class CirculLabel: UILabel {

    override func awakeFromNib() {
        layer.cornerRadius = 50
        layer.borderWidth = 10
        layer.borderColor = ORANGE_COLOR.CGColor
    }

}
