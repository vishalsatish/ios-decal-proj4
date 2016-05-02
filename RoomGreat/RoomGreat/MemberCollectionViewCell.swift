//
//  MemberCollectionViewCell.swift
//  RoomGreat
//
//  Created by Vishal Satish on 4/23/16.
//  Copyright © 2016 Vishal Satish. All rights reserved.
//

import UIKit

class MemberCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var memberName: UILabel!
    
    var member: Member!
    
}
