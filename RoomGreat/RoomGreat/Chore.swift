//
//  Chore.swift
//  RoomGreat
//
//  Created by Vishal Satish on 4/13/16.
//  Copyright © 2016 Vishal Satish. All rights reserved.
//

import UIKit

class Chore {
    var name: String!
    var description: String
    var interval: (Int, String)
    var members: [Member]
    var endRepeat: NSDate
    var end: NSDate
    
    init (name: String, description: String, interval: (Int, String), members: [Member], endRepeat: NSDate, end: NSDate) {
        self.name = name
        self.description = description
        self.interval = interval
        self.members = members
        self.endRepeat = endRepeat
        self.end = end
    }
}
