//
//  GroupMemberCollectionViewCell.swift
//  RoomGreat
//
//  Created by Vishal Satish on 5/1/16.
//  Copyright © 2016 Vishal Satish. All rights reserved.
//

import UIKit

class GroupMemberCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var memberName: UILabel!
    
    var member: Member!
}
