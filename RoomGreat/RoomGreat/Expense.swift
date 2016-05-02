//
//  Expense.swift
//  RoomGreat
//
//  Created by Vishal Satish on 4/26/16.
//  Copyright © 2016 Vishal Satish. All rights reserved.
//

import UIKit

class Expense {
    var name: String!
    var description: String
    var interval: String
    var members = [Member]()
    
    init (name: String, description: String, interval: String, members: [Member]) {
        self.name = name
        self.description = description
        self.interval = interval
        self.members = members
    }
}
