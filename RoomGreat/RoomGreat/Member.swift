//
//  Member.swift
//  RoomGreat
//
//  Created by Vishal Satish on 4/13/16.
//  Copyright © 2016 Vishal Satish. All rights reserved.
//

import UIKit

class Member: Equatable {
    var fname: String
    var lname: String
    var image: UIImage
    
    init (fname: String, lname: String, image: UIImage) {
        self.fname = fname
        self.lname = lname
        self.image = image
    }
}

func == (lhs: Member, rhs: Member) -> Bool {
    return lhs.fname == rhs.fname && lhs.lname == rhs.lname && lhs.image == rhs.image
}