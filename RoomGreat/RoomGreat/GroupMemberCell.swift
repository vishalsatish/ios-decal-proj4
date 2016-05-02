//
//  GroupMemberCell.swift
//  RoomGreat
//
//  Created by Vishal Satish on 4/24/16.
//  Copyright © 2016 Vishal Satish. All rights reserved.
//

import UIKit

class GroupMemberCell: UITableViewCell {
    
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var memberName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
