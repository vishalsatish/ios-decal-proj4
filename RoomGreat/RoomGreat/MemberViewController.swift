//
//  MemberViewController.swift
//  RoomGreat
//
//  Created by Vishal Satish on 4/25/16.
//  Copyright © 2016 Vishal Satish. All rights reserved.
//

import UIKit

class MemberViewController: UIViewController {
    
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var memberName: UILabel!
//    @IBOutlet weak var memberEmail: UILabel!
//    @IBOutlet weak var memberPhone: UILabel!
//    @IBOutlet weak var memberBirthday: UILabel!
    
    var member: Member!
    var source: AnyObject?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        memberImage.image = member.image
        memberImage.layer.cornerRadius = memberImage.frame.size.width/2
        memberImage.clipsToBounds = true
        memberName.text = member.fname + " " + member.lname
//        memberEmail.text = member.email
//        memberPhone.text = member.phone
//        memberBirthday.text = member.bday
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editMember" {
            let nav = segue.destinationViewController as! UINavigationController
            let receiver = nav.topViewController as! AddMemberViewController
            receiver.newMember = member
            receiver.source = segue.sourceViewController
        }
    }
    
    @IBAction func unwindToMemberViewController(sender: UIStoryboardSegue) {
        if let source = sender.sourceViewController as? AddMemberViewController, editedMember = source.newMember {
            if source.persist {
                if let controller = self.source as? MemberCollectionViewController {
                    while controller.members.contains(member) {
                        if let itemToRemoveIndex = controller.members.indexOf(member) {
                            controller.members[itemToRemoveIndex] = editedMember
                        }
                    }
                    let secondTab = (self.source!.tabBarController?!.viewControllers![0] as! UINavigationController).topViewController as! GroupTableViewController
                    secondTab.allMembers = controller.members
                    controller.edit = (member, editedMember)
                    member = editedMember
                    viewDidLoad()
                } else {
                    while (self.source as! GroupMemberCollectionViewController).members.contains(member) {
                        if let itemToRemoveIndex = (self.source as! GroupMemberCollectionViewController).members.indexOf(member) {
                            (self.source as! GroupMemberCollectionViewController).members[itemToRemoveIndex] = editedMember
                        }
                    }
                    let secondTab = (self.source!.tabBarController?!.viewControllers![0] as! UINavigationController).topViewController as! ChoreTableViewController
                    secondTab.group.members = (self.source as! GroupMemberCollectionViewController).members
                    (self.source as! GroupMemberCollectionViewController).edit = (member, editedMember)
                    member = editedMember
                    viewDidLoad()
                }
            }
        }
    }
        
}
