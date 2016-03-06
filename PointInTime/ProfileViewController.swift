//
//  ProfileViewController.swift
//  PointInTime
//
//  Created by EricDev on 3/5/16.
//  Copyright © 2016 EricDev. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var name: UILabel!
    var imageHolder: UIImage!
    var profileObject: PFObject?
    var tempvc = loggedInView()
    
    var vc = UIImagePickerController()
    var setter: ParsePictureSetter? {
        willSet {
            self.profilePicture.image = setter?.image
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        name.text = PFUser.currentUser()?.username
        name.sizeToFit()
        profileObject = loadProfile((PFUser.currentUser()?.username)!){ (result: PFObject) in
            print("result \(result)") }
        self.profilePicture.image = self.setter?.image
        self.profilePicture.image = tempvc.preload?.image
        self.navigationController
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(false)
        self.profilePicture.image = self.setter?.image
        self.view.layoutIfNeeded()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(false)
        self.profilePicture.image = self.setter?.image
    }
    
    func fetchPicture() {
        print("inside fetch \(profileObject)")
        if let userPicture = self.profileObject!.valueForKey("profilePicture")! as? PFFile {
            userPicture.getDataInBackgroundWithBlock({
                (imageData: NSData?, error: NSError?) -> Void in
                if (error == nil) {
                    let image = UIImage(data:imageData!)
                    self.profilePicture.image = image
                    print("profile picture loaded")
                }
            })
        }
    }
    
                    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            imageHolder = originalImage
            profilePicture.image = originalImage
            //self.setter?.imageFrame?.image = originalImage
            
            // Dismiss UIImagePickerController to go back to your original view controller
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onChangeProfilePicture(sender: AnyObject) {
        self.presentViewController(vc, animated: true, completion: nil)
    }

    @IBAction func onCreateProfile(sender: AnyObject) {
        let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.Indeterminate
        loadingNotification.labelText = "Creating Profile"
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        Post.postUserProfile(imageHolder){ (success: Bool, error: NSError?) -> Void in
            print("\(success): Profile Created")
            if error == nil {
                MBProgressHUD.hideHUDForView(self.view, animated: false)
            }
            
            MBProgressHUD.hideHUDForView(self.view, animated: false)
            //print(error)
        }
    }

    @IBAction func onUpdateProfile(sender: AnyObject) {
    }
    
    func loadProfile(name: String, completion: (result: PFObject) -> Void) -> PFObject? {
        var posts1: PFObject?
        let query = PFQuery(className:"Profile")
        query.whereKey("name", equalTo: "\(name)")
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects {
                    for object in objects {
                    self.profileObject = object
                    posts1 = object
                    self.setter = ParsePictureSetter(profileObject: object)
                    self.profilePicture.image = self.setter!.imageFrame?.image
                    print(object)
                    }
                    MBProgressHUD.hideHUDForView(self.view, animated: false)
                }
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        MBProgressHUD.hideHUDForView(self.view, animated: false)
        }
        return posts1
    }
}
