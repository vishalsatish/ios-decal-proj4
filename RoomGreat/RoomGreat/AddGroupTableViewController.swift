//
//  AddGroupTableViewController.swift
//  RoomGreat
//
//  Created by Vishal Satish on 5/1/16.
//  Copyright © 2016 Vishal Satish. All rights reserved.
//

import UIKit

class AddGroupTableViewController: UITableViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    var newGroup: Group?
    var members = [Member]()
    var allMembers = [Member]()
    var nameCell: GroupNameCell?
    var addressCell: GroupAddressCell?
    var imageCell: GroupImageCell?
    @IBOutlet weak var doneButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        if members.count == 0 || nameCell?.groupName.text?.characters.count == 0 {
            doneButton.enabled = false
        } else {
            doneButton.enabled = true
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        if members.count == 0 || nameCell?.groupName.text?.characters.count == 0 {
            doneButton.enabled = false
        } else {
            doneButton.enabled = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 3
        default:
            return members.count + 2
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("GroupImageCell", forIndexPath: indexPath) as! GroupImageCell
                let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImageFromPhotoLibrary(_:)))
                gestureRecognizer.cancelsTouchesInView = false
                gestureRecognizer.numberOfTapsRequired = 1
                gestureRecognizer.delegate = self
                cell.groupImage.userInteractionEnabled = true
                cell.groupImage.addGestureRecognizer(gestureRecognizer)
                cell.groupImage.layer.cornerRadius = cell.groupImage.frame.size.width/2
                cell.groupImage.clipsToBounds = true
                cell.selectionStyle = .None
                imageCell = cell
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("GroupNameCell", forIndexPath: indexPath) as! GroupNameCell
                cell.selectionStyle = .None
                nameCell = cell
                cell.groupName.becomeFirstResponder()
                cell.source = self
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("GroupAddressCell", forIndexPath: indexPath) as! GroupAddressCell
                cell.selectionStyle = .None
                addressCell = cell
                return cell
            }
        default:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("createNew", forIndexPath: indexPath)
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("GroupChooseMemberCell", forIndexPath:
                    indexPath) as! GroupChooseMemberCell
                if allMembers.count == 0 {
                    cell.selectionStyle = .None
                    cell.userInteractionEnabled = false
                    cell.chooseText.enabled = false
                } else {
                    cell.selectionStyle = .Default
                    cell.userInteractionEnabled = true
                    cell.chooseText.enabled = true
                }
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("GroupMemberCell", forIndexPath: indexPath) as! GroupMemberCell
                let member = members[indexPath.row - 2]
                cell.memberName.text = member.fname
                cell.memberImage.image = member.image
                cell.memberImage.layer.cornerRadius = cell.memberImage.frame.size.width/2
                cell.memberImage.clipsToBounds = true
                cell.selectionStyle = .None
                return cell
            }
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 190
        }
        else {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }

    // MARK: - Image picker
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        imageCell!.groupImage.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
        tableView.reloadData()
    }
    
    func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        //        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.destinationViewController is GroupTableViewController {
            if doneButton === sender {
                newGroup = Group(name: nameCell!.groupName.text ?? "", members: members, image: imageCell!.groupImage.image!, address: addressCell!.groupAddress.text ?? "")
                for member in members {
                    if !(allMembers.contains(member)) {
                        allMembers.append(member)
                    }
                }
            }
        } else if segue.identifier == "chooseMember" {
            let nav = segue.destinationViewController as! UINavigationController
            let receiver = nav.topViewController as! ChooseMemberTableViewController
            receiver.members = allMembers
            receiver.source = segue.sourceViewController
            receiver.chosen = members
        } else if segue.identifier == "addMember" {
            let nav: UINavigationController = segue.destinationViewController as! UINavigationController
            let controller: AddMemberViewController = nav.topViewController as! AddMemberViewController
            controller.source = segue.sourceViewController
        }
    }
    
    @IBAction func unwindToAddGroupTableViewController(sender: UIStoryboardSegue) {
        if let source = sender.sourceViewController as? AddMemberViewController, newMember = source.newMember {
            let newIndexPath = NSIndexPath(forRow: members.count + 2, inSection: 1)
            members.append(newMember)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        } else if let source = sender.sourceViewController as? ChooseMemberTableViewController {
            if source.persist {
                members = source.chosen
                tableView.reloadData()
            }
        }
    }

}
