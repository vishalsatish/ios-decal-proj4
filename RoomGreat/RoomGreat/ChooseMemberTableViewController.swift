//
//  ChooseMemberTableViewController.swift
//  RoomGreat
//
//  Created by Vishal Satish on 4/23/16.
//  Copyright © 2016 Vishal Satish. All rights reserved.
//

import UIKit

class ChooseMemberTableViewController: UITableViewController {
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    var persist: Bool = false
    var members = [Member]()
    var chosen = [Member]()
    
    var source: AnyObject?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        if self.source!.isKindOfClass(AddChoreTableViewController) {
            doneButton.title = "Next"
        } else {
            doneButton.title = "Done"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return members.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChooseMemberTableViewCell", forIndexPath: indexPath) as! ChooseMemberTableViewCell
        let member = members[indexPath.row]
        // Configure the cell...
        cell.memberImage.image = member.image
        cell.memberImage.layer.cornerRadius = cell.memberImage.frame.size.width/2
        cell.memberImage.clipsToBounds = true
        cell.memberName.text = member.fname + " " + member.lname
        if chosen.contains(member) {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let tappedItem = members[indexPath.row]
        if chosen.contains(tappedItem) {
            chosen.removeAtIndex(chosen.indexOf(tappedItem)!)
        } else {
            chosen.append(tappedItem)
        }
        tableView.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    @IBAction func buttonPressed(sender: UIBarButtonItem) {
        if self.source!.isKindOfClass(AddGroupTableViewController) {
            performSegueWithIdentifier("unwindToAddGroupTableViewController2", sender: sender)
        } else if self.source!.isKindOfClass(AddChoreTableViewController) {
            if sender === doneButton {
                persist = true
                performSegueWithIdentifier("reorder", sender: sender)
            } else {
                persist = false
                performSegueWithIdentifier("unwindToAddChoreTableViewController", sender: sender)
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if doneButton === sender {
            persist = true
            if segue.identifier == "reorder" {
                let receiver = segue.destinationViewController as! ReorderTableViewController
                receiver.members = chosen
            }
        }
    }

}
