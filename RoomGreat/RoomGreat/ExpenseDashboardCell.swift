//
//  ExpenseDashboardCell.swift
//  RoomGreat
//
//  Created by Vishal Satish on 4/27/16.
//  Copyright © 2016 Vishal Satish. All rights reserved.
//

import UIKit

class ExpenseDashboardCell: UITableViewCell {
    
    @IBOutlet weak var expenseName: UILabel!
    @IBOutlet weak var expenseInterval: UILabel!
    @IBOutlet weak var expenseDue: UILabel!
    @IBOutlet weak var expenseAmount: UILabel!
    
    var expense: Expense!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
