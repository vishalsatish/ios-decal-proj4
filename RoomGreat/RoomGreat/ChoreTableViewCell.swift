//
//  ChoreDashboardCell.swift
//  RoomGreat
//
//  Created by Vishal Satish on 4/27/16.
//  Copyright © 2016 Vishal Satish. All rights reserved.
//

import UIKit

class ChoreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var choreName: UILabel!
    @IBOutlet weak var choreInterval: UILabel!
    @IBOutlet weak var choreDue: UILabel!
    @IBOutlet weak var choreMemberImage: UIImageView!
    @IBOutlet weak var choreMemberName: UILabel!
    
    var chore: Chore!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
