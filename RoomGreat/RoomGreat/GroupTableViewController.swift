//
//  GroupListTableViewController.swift
//  RoomGreat
//
//  Created by Vishal Satish on 4/13/16.
//  Copyright © 2016 Vishal Satish. All rights reserved.
//

import UIKit

class GroupTableViewController: UITableViewController {
    
    var groups = [Group]()
    var allMembers = [Member]()
    var selectedGroup: Group!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
        if groups.count == 0 {
            let screen = UIScreen.mainScreen().bounds.size
            let label = UILabel(frame: CGRectMake(screen.width/2-100, screen.height/2-100, 200, 200))
            label.textAlignment = NSTextAlignment.Center
            label.text = "No Groups created."
            self.view.addSubview(label)
        } else {
            for subview in self.view.subviews {
                if subview is UILabel {
                    subview.removeFromSuperview()
                }
            }
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
        return groups.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GroupTableViewCell", forIndexPath: indexPath) as! GroupTableViewCell

        // Configure the cell...
        let group = groups[indexPath.row]
        cell.group = group
        cell.groupName.text = group.name
        cell.groupAddress.text = group.address
        cell.groupImage.image = group.image
        cell.groupImage.layer.cornerRadius = cell.groupImage.frame.size.width/2
        cell.groupImage.clipsToBounds = true

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            groups.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! GroupTableViewCell
        selectedGroup = cell.group
        performSegueWithIdentifier("toGroup", sender: self)
    }

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
        if segue.identifier == "addGroup" {
            let nav = segue.destinationViewController as! UINavigationController
            let receiver = nav.topViewController as! AddGroupTableViewController
            receiver.allMembers = allMembers
        } else if segue.identifier == "toGroup" {
            let tab = segue.destinationViewController as! UITabBarController
            let nav = tab.viewControllers![0] as! UINavigationController
            let receiver = nav.topViewController as! ChoreTableViewController
            receiver.group = selectedGroup
        }
    }

    @IBAction func unwindToGroupTableViewController(sender: UIStoryboardSegue) {
        if let source = sender.sourceViewController as? AddGroupTableViewController, newGroup = source.newGroup {
            let newIndexPath = NSIndexPath(forRow: groups.count, inSection: 0)
            groups.append(newGroup)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            allMembers = source.allMembers
            let secondTab = (self.tabBarController?.viewControllers![1] as! UINavigationController).topViewController as! MemberCollectionViewController
            secondTab.members = allMembers
        }
    }
}
