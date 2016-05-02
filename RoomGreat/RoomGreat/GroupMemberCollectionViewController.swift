//
//  GroupMemberCollectionViewController.swift
//  RoomGreat
//
//  Created by Vishal Satish on 5/1/16.
//  Copyright © 2016 Vishal Satish. All rights reserved.
//

import UIKit

class GroupMemberCollectionViewController: UICollectionViewController {

    var members = [Member]()
    var selectedMember: Member!
    var edit: (Member, Member)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        collectionView?.reloadData()
        if members.count == 0 {
            let screen = UIScreen.mainScreen().bounds.size
            let label = UILabel(frame: CGRectMake(screen.width/2-100, screen.height/2-100, 200, 200))
            label.textAlignment = NSTextAlignment.Center
            label.text = "No Member profiles."
            self.view.addSubview(label)
        } else {
            for subview in self.view.subviews {
                if subview is UILabel {
                    subview.removeFromSuperview()
                }
            }
        }
        let secondTab = (self.tabBarController?.viewControllers![0] as! UINavigationController).topViewController as! ChoreTableViewController
        if edit != nil {
            for (id, member) in secondTab.group.members.enumerate() {
                if member == edit!.0 && member != edit!.1 {
                    secondTab.group.members[id] = edit!.1
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return members.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GroupMemberCollectionViewCell", forIndexPath: indexPath) as! GroupMemberCollectionViewCell
        
        // Configure the cell
        cell.member = members[indexPath.row]
        cell.memberImage.image = cell.member.image
        cell.memberName.text = cell.member.fname
        cell.memberImage.layer.cornerRadius = cell.memberImage.frame.size.width/2
        cell.memberImage.clipsToBounds = true
        return cell
    }
    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let totalHeight: CGFloat = (self.view.frame.width / 3) * (7/6)
        let totalWidth: CGFloat = (self.view.frame.width / 3)
        return CGSizeMake(ceil(totalWidth), ceil(totalHeight))
    }
    
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! GroupMemberCollectionViewCell
        selectedMember = cell.member
        return true
    }
    
    
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return false
     }
     
     override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
     return false
     }
     
     override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
     
     }
     */
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "addNewMember2" {
            let nav: UINavigationController = segue.destinationViewController as! UINavigationController
            let controller: AddMemberViewController = nav.topViewController as! AddMemberViewController
            controller.source = segue.sourceViewController
        } else if let receiver = segue.destinationViewController as? MemberViewController {
            receiver.member = selectedMember
            receiver.source = segue.sourceViewController
        }
    }
    
    @IBAction func unwindToGroupMemberCollectionViewController(sender: UIStoryboardSegue) {
        if let source = sender.sourceViewController as? AddMemberViewController, newMember = source.newMember {
            let newIndexPath = NSIndexPath(forRow: members.count, inSection: 0)
            members.append(newMember)
            let indexPaths = NSArray(object: newIndexPath)
            collectionView?.insertItemsAtIndexPaths(indexPaths as! [NSIndexPath])
            let secondTab = (self.tabBarController?.viewControllers![0] as! UINavigationController).topViewController as! ChoreTableViewController
            secondTab.group.members = members
        }
    }

}
