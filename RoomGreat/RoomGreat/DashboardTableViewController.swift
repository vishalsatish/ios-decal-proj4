//
//  DashboardTableViewController.swift
//  RoomGreat
//
//  Created by Vishal Satish on 4/26/16.
//  Copyright © 2016 Vishal Satish. All rights reserved.
//

import UIKit

class DashboardTableViewController: UITableViewController {
    
    var sections = ["Chores", "Expenses", "Rewards"]
    var chores = [Chore]()
    var expenses = [Expense]()
    var rewards = [Reward]()
    var items : [[Any]] {
        get {
            return [
                chores,
                expenses,
                rewards
            ]
        }
    }
    var group: Group!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.navigationItem.title = "Dashboard"
        let secondTab = (self.tabBarController?.viewControllers![1] as! UINavigationController).topViewController as! ChoreTableViewController
        secondTab.group = group
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.sections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if items[section].count > 0 {
            return self.items[section].count
        } else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Configure the cell...
        if self.items[indexPath.section].count == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("noItems", forIndexPath: indexPath)
            return cell
        }
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ChoreTableViewCell", forIndexPath: indexPath) as! ChoreTableViewCell
            let chore = self.items[indexPath.section][indexPath.row] as! Chore
            cell.chore = chore
            cell.choreName.text = chore.name
            cell.choreInterval.text = chore.interval
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ExpenseDashboardCell", forIndexPath: indexPath) as! ExpenseDashboardCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("RewardDashboardCell", forIndexPath: indexPath) as! RewardDashboardCell
            return cell
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
