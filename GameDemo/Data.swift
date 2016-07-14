//
//  Data.swift
//  GameDemo
//
//  Created by Altynai Orynbayeva on 7/8/16.
//  Copyright © 2016 Altynai Orynbaeva. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var annotation = ""
    dynamic var points = 0
}

// Words model
class Word: Object {
//    dynamic var id = 0
    dynamic var category :Category?
    dynamic var word = ""
}

//Team model
class Team: Object {
    dynamic var team_id = 0
    dynamic var result = 0
    dynamic var isMove:Bool = false
    dynamic var isChangeCategory:Bool = true
}
