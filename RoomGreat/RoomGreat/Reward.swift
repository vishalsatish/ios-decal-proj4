//
//  Reward.swift
//  RoomGreat
//
//  Created by Vishal Satish on 4/26/16.
//  Copyright © 2016 Vishal Satish. All rights reserved.
//

import UIKit

class Reward {
    var value: Int = 0
    var member: Member!
    
    init (value: Int, member: Member) {
        self.value = value
        self.member = member
    }
}