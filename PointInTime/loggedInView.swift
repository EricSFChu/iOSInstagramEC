//
//  loggedInView.swift
//  PointInTime
//
//  Created by EricDev on 2/29/16.
//  Copyright © 2016 EricDev. All rights reserved.
//

import UIKit
import Parse


class loggedInView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let vc = UIImagePickerController()
    var imageHolder: UIImage!
    @IBOutlet weak var imageFrame: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.navigationController
        
    }
 
    @IBAction func onClickAddPhoto(sender: AnyObject) {
        self.presentViewController(vc, animated: true, completion: nil)
    }
    override func viewDidAppear(animated: Bool) {
        
        
    }

    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            imageHolder = originalImage
            imageFrame.image = originalImage
            
            // Dismiss UIImagePickerController to go back to your original view controller
            dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOut()
        self.dismissViewControllerAnimated(true, completion: nil)
            print("Logged Out")
 
    }
}
