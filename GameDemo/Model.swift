//
//  Model.swift
//  GameDemo
//
//  Created by Altynai Orynbayeva on 7/7/16.
//  Copyright © 2016 Altynai Orynbaeva. All rights reserved.
//

import Foundation
import RealmSwift

// Category model
class Category: Object {
    dynamic var object_id = 0
    dynamic var name = " "
    dynamic var descrypt = " "
    dynamic var points = 0
}

// Words model
class Words: Object {
    dynamic var word_id = 0
    dynamic var category :Category?
    dynamic var priority = 0
    dynamic var word = " "
 
    
}
//Team model
class Teams: Object {
    dynamic var team_id = 0
    dynamic var result = 0

    
}

