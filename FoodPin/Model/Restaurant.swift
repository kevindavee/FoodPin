//
//  Restaurant.swift
//  FoodPin
//
//  Created by Kevin  Dave on 02/10/17.
//  Copyright © 2017 Kevin Dave. All rights reserved.
//

import Foundation

class Restaurant {
    var name = ""
    var type = ""
    var location = ""
    var image = ""
    var isVisited = false
    var phone = ""
    var rating = ""
    
    init(name: String, type: String, location: String, image: String, isVisited: Bool, phone: String) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isVisited = isVisited
        self.phone = phone
    }
}
