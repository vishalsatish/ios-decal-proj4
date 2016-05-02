//
//  ChoreTableViewController.swift
//  RoomGreat
//
//  Created by Vishal Satish on 4/28/16.
//  Copyright © 2016 Vishal Satish. All rights reserved.
//

import UIKit

class ChoreTableViewController: UITableViewController {
    
    var chores = [Chore]()
    var selectedChore: Chore!
    var group: Group!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        group.chores = chores
        let secondTab = (self.tabBarController?.viewControllers![1] as! UINavigationController).topViewController as! GroupMemberCollectionViewController
        secondTab.members = group.members
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
        if chores.count == 0 {
            let screen = UIScreen.mainScreen().bounds.size
            let label = UILabel(frame: CGRectMake(screen.width/2-100, screen.height/2-100, 200, 200))
            label.textAlignment = NSTextAlignment.Center
            label.text = "No active chores."
            self.view.addSubview(label)
        } else {
            for subview in self.view.subviews {
                if subview is UILabel {
                    subview.removeFromSuperview()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return chores.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChoreTableViewCell", forIndexPath: indexPath) as! ChoreTableViewCell

        // Configure the cell...
        let chore = chores[indexPath.row]
        cell.chore = chore
        cell.choreName.text = chore.name
        cell.choreInterval.text = String(chore.interval.0) + " " + chore.interval.1
        cell.choreDue.text = NSDateFormatter.localizedStringFromDate(chore.end, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: .NoStyle)
        cell.choreMemberImage.image = chore.members[0].image
        cell.choreMemberName.text = chore.members[0].fname

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ChoreTableViewCell
        selectedChore = cell.chore
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let nav = segue.destinationViewController as! UINavigationController
        let receiver = nav.topViewController as! AddChoreTableViewController
        receiver.group = group
    }
    
    @IBAction func unwindToChoreTableViewController(sender: UIStoryboardSegue) {
        if let source = sender.sourceViewController as? AddChoreTableViewController, newChore = source.newChore {
            let newIndexPath = NSIndexPath(forRow: chores.count, inSection: 0)
            var success: Bool = false
            for (idx, chore) in chores.enumerate() {
                if newChore.end.compare(chore.end) == NSComparisonResult.OrderedAscending {
                    chores.insert(newChore, atIndex: idx)
                    success = true
                    break
                }
            }
            if !success {
                chores.append(newChore)
            }
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            tableView.reloadData()
        }
    }

}
