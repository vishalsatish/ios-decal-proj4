//
//  AddMemberViewController.swift
//  RoomGreat
//
//  Created by Vishal Satish on 4/23/16.
//  Copyright © 2016 Vishal Satish. All rights reserved.
//

import UIKit
import ContactsUI

class AddMemberViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CNContactPickerDelegate {
    
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var importButton: UIButton!
    
    var newMember: Member?
    
    var source: AnyObject?
    
    var contact = CNContact()
    
    var persist: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        firstName.becomeFirstResponder()
        firstName.delegate = self
        checkValidMemberName()
        firstName.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        memberImage.layer.cornerRadius = memberImage.frame.size.width/2
        memberImage.clipsToBounds = true
        importButton.addTarget(self, action: #selector(addExistingContact), forControlEvents: .TouchUpInside)
        
        if self.source!.isKindOfClass(MemberViewController) {
            memberImage.image = newMember?.image
            firstName.text = newMember?.fname
            lastName.text = newMember?.lname
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AddMemberViewController.insertNewObject(_:)), name: "addNewContact", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: UITextFieldDelegate
    
    // Disable the Done button if the text field is empty.
    func checkValidMemberName() {
        let text = firstName.text ?? ""
        doneButton.enabled = !text.isEmpty
    }
    
    func textFieldDidChange(textField: UITextField) {
        checkValidMemberName()
    }
    

    
    func addExistingContact() {
        let store = CNContactStore()
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        if CNContactStore.authorizationStatusForEntityType(.Contacts) == .NotDetermined {
            store.requestAccessForEntityType(.Contacts, completionHandler: { (authorized: Bool, error: NSError?) -> Void in
                if authorized {
                    self.presentViewController(contactPicker, animated: true, completion: nil)
                }
            })
        } else if CNContactStore.authorizationStatusForEntityType(.Contacts) == .Authorized {
            self.presentViewController(contactPicker, animated: true, completion: nil)
        } else if CNContactStore.authorizationStatusForEntityType(.Contacts) == .Denied {
            let alertController = UIAlertController(title: "This app does not have access to your contacts.", message: "You can enable access in Privacy Settings.", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Ok", style: .Cancel) { (action) in
            }
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true) {
            }
        }
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
        NSNotificationCenter.defaultCenter().postNotificationName("addNewContact", object: nil, userInfo: ["contactToAdd": contact])
    }
    
    func insertNewObject(sender: NSNotification) {
        if let contact = sender.userInfo?["contactToAdd"] as? CNContact {
            self.contact = contact
            if contact.imageDataAvailable {
                if let data = contact.imageData {
                    self.memberImage.image = UIImage(data: data)
                }
            }
            let fullName = CNContactFormatter().stringFromContact(contact)
            let fullNameArr = fullName?.characters.split{$0 == " "}.map(String.init)
            let firstNameArr : [String]
            if fullNameArr![fullNameArr!.count - 1] != "Jr." && fullNameArr![fullNameArr!.count - 1] != "Sr." {
                firstNameArr = Array(fullNameArr![0...fullNameArr!.count - 2])
                self.lastName.text = fullNameArr![fullNameArr!.count - 1]
            } else {
                firstNameArr = Array(fullNameArr![0...fullNameArr!.count - 3])
                self.lastName.text = fullNameArr![fullNameArr!.count - 2] + " " + fullNameArr![fullNameArr!.count - 1]
            }
            self.firstName.text = firstNameArr.joinWithSeparator(" ")
            doneButton.enabled = true
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
        memberImage.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        firstName.resignFirstResponder()
        lastName.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        //        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }

    
    @IBAction func buttonPressed(sender: UIBarButtonItem) {
        if self.source!.isKindOfClass(AddGroupTableViewController) {
            performSegueWithIdentifier("unwindToAddGroupTableViewController", sender: sender)
        } else if self.source!.isKindOfClass(MemberCollectionViewController) {
            performSegueWithIdentifier("unwindToMemberCollectionViewController", sender: sender)
        } else if self.source!.isKindOfClass(MemberViewController) {
            performSegueWithIdentifier("unwindToMemberViewController", sender: sender)
        } else if self.source!.isKindOfClass(GroupMemberCollectionViewController) {
            performSegueWithIdentifier("unwindToGroupMemberCollectionViewController", sender: sender)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if doneButton === sender {
            newMember = Member(fname: firstName.text ?? "", lname: lastName.text ?? "", image: memberImage.image!)
            persist = true
        }
    }

}
