//
//  Group.swift
//  RoomGreat
//
//  Created by Vishal Satish on 4/13/16.
//  Copyright © 2016 Vishal Satish. All rights reserved.
//

import UIKit

class Group {
    var name: String
    var image: UIImage
    var members: [Member]
    var address: String
    var chores = [Chore]()
    
    init (name: String, members: [Member], image: UIImage, address: String) {
        self.name = name
        self.members = members
        self.image = image
        self.address = address
    }
}
