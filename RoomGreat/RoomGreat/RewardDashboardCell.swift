//
//  RewardDashboardCell.swift
//  RoomGreat
//
//  Created by Vishal Satish on 4/27/16.
//  Copyright © 2016 Vishal Satish. All rights reserved.
//

import UIKit

class RewardDashboardCell: UITableViewCell {
    
    @IBOutlet weak var rewardMemberImage: UIImageView!
    @IBOutlet weak var rewardMemberName: UILabel!
    @IBOutlet weak var rewardStatusBar: UIProgressView!
    @IBOutlet weak var rewardStatusAmount: UILabel!
    
    var reward: Reward!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
