//
//  GroupTableViewCell.swift
//  RoomGreat
//
//  Created by Vishal Satish on 4/14/16.
//  Copyright © 2016 Vishal Satish. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var groupAddress: UILabel!
    
    var group: Group!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
