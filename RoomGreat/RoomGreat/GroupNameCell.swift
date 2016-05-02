//
//  GroupNameCell.swift
//  RoomGreat
//
//  Created by Vishal Satish on 5/1/16.
//  Copyright © 2016 Vishal Satish. All rights reserved.
//

import UIKit

class GroupNameCell: UITableViewCell {
    
    @IBOutlet weak var groupName: UITextField!
    
    var source: AnyObject?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func editingChanged(sender: AnyObject) {
        if groupName.text!.characters.count > 0 {
            if (source as! AddGroupTableViewController).members.count > 0 {
                (source as! AddGroupTableViewController).doneButton.enabled = true
            } else {
                (source as! AddGroupTableViewController).doneButton.enabled = false
            }
        } else {
            (source as! AddGroupTableViewController).doneButton.enabled = false
        }
    }

}
