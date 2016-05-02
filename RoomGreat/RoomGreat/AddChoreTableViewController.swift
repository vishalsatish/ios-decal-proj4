//
//  AddChore2TableViewController.swift
//  RoomGreat
//
//  Created by Vishal Satish on 5/1/16.
//  Copyright © 2016 Vishal Satish. All rights reserved.
//

import UIKit

class AddChoreTableViewController: UITableViewController {
    
    var group: Group!
    var members = [Member]()
    
    var nameCell: ChoreNameCell?
    var dueCell: ChoreDueCell?
    var datePicker: DatePickerCell?
    var dayCell: AllDayCell?
    var repCell: RepeatCell?
    var endCell: EndRepeatCell?
    var desCell: DescriptionCell?
    
    var first: Int?
    var second: String?
    
    var endRepeat: NSDate?
    
    var end: NSDate?
    
    var newChore: Chore?

    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
//        if members.count > 0 {
//            tableView.setEditing(true, animated: true)
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        if members.count == 0 {
            doneButton.enabled = false
        } else{
            doneButton.enabled = true
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 1
        case 1:
            if members.count == 0 {
                return members.count + 1
            } else {
                return members.count + 2
            }
        case 2:
            return 5
        default:
            return 1
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        // Configure the cell...
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("choreName", forIndexPath: indexPath) as! ChoreNameCell
            nameCell = cell
            return cell
        case 1:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("addMember", forIndexPath: indexPath)
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("editOrder", forIndexPath: indexPath)
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("choreMember", forIndexPath: indexPath) as! ChoreMemberTableViewCell
                let member = members[indexPath.row - 2]
                cell.memberImage.image = member.image
                cell.memberName.text = member.fname + " " + member.lname
                cell.memberNumber.text = String(indexPath.row - 1)
                return cell
            }
        case 2:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("allDay", forIndexPath: indexPath) as! AllDayCell
                dayCell = cell
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("due", forIndexPath: indexPath) as! ChoreDueCell
                cell.userInteractionEnabled = true
                dueCell = cell
                return cell
            case 2:
                let cell = tableView.dequeueReusableCellWithIdentifier("datePicker", forIndexPath: indexPath) as! DatePickerCell
                datePicker = cell
                datePickerChanged()
                return cell
            case 3:
                let cell = tableView.dequeueReusableCellWithIdentifier("repeat", forIndexPath: indexPath) as! RepeatCell
                if first == nil || first == 0 {
                    cell.detail.text = "Never"
                } else {
                    cell.detail.text = String(first) + " " + second!
                }
                repCell = cell
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("endRepeat", forIndexPath: indexPath) as! EndRepeatCell
                endCell = cell
                return cell
            }
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("description", forIndexPath: indexPath) as! DescriptionCell
            desCell = cell
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 2 && indexPath.row == 1 {
            toggleDatepicker()
        }
    }
    
    var datePickerHidden = true
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if datePickerHidden && indexPath.section == 2 && indexPath.row == 2 {
            return 0
        }
        else {
            if indexPath.section == 2 && indexPath.row == 2 {
                return 219
            } else {
                return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
            }
        }
    }
    
    func datePickerChanged() {
        if dayCell!.toggle.on {
            datePicker?.datePicker.datePickerMode = .Date
            dueCell!.detail.text = NSDateFormatter.localizedStringFromDate(datePicker!.datePicker.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: .NoStyle)
        } else {
            datePicker?.datePicker.datePickerMode = .DateAndTime
            dueCell!.detail.text = NSDateFormatter.localizedStringFromDate(datePicker!.datePicker.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        }
        end = datePicker?.datePicker.date
    }
    
    func toggleDatepicker() {
        datePickerHidden = !datePickerHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }

    @IBAction func datePickerValue(sender: AnyObject) {
        datePickerChanged()
    }
    
    @IBAction func switchValue(sender: AnyObject) {
        datePickerChanged()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "chooseMembers" {
            let nav: UINavigationController = segue.destinationViewController as! UINavigationController
            let controller: ChooseMemberTableViewController = nav.topViewController as! ChooseMemberTableViewController
            controller.source = segue.sourceViewController
            controller.members = group.members 
        } else if segue.identifier == "editOrder" {
            let controller = segue.destinationViewController as! ReorderTableViewController
            controller.members = members
        } else if sender === doneButton {
            newChore = Chore(name: nameCell!.choreName.text ?? "", description: desCell!.choreDesc.text ?? "", interval: (first ?? 0, second ?? ""), members: members, endRepeat: endRepeat ?? NSDate(), end: end ?? NSDate())
        }
    }
    
    @IBAction func unwindToAddChoreTableViewController(sender: UIStoryboardSegue) {
        if let source = sender.sourceViewController as? ChooseMemberTableViewController {
            if source.persist {
                members = source.chosen
                tableView.reloadData()
            }
        } else if let source = sender.sourceViewController as? RepeatTableViewController {
            first = Int(source.first!)
            second = source.second
        } else if sender.sourceViewController.isKindOfClass(ReorderTableViewController) {
            tableView.reloadData()
        } else if let source = sender.sourceViewController as? EndRepeatTableViewController {
            endRepeat = source.end
        }
    }

}
