//
//  ChoreMember2TableViewCell.swift
//  RoomGreat
//
//  Created by Vishal Satish on 5/1/16.
//  Copyright © 2016 Vishal Satish. All rights reserved.
//

import UIKit

class ChoreMemberTableViewCell: UITableViewCell {
    
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var memberNumber: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
