//
//  PointInTime.swift
//  PointInTime
//
//  Created by EricDev on 3/4/16.
//  Copyright © 2016 EricDev. All rights reserved.
//

import UIKit
import Parse

class PointInTime: NSObject {

    var media: UIImage?
    var author: PFUser?
    var caption: String?
    var likesCount: Int?
    var commentsCount: Int?
    var name: String?
    var tempCell: PointInTimeCell?
    var profilePicture: UIImage?
    
    init(pointObject: PFObject) {
        super.init()
        tempCell = PointInTimeCell()
        print("This is it \(pointObject)")
        caption = pointObject["caption"] as? String
        //tempCell!.captionLabel.text = caption
        likesCount = pointObject["likesCount"] as? Int
        commentsCount = pointObject["commentsCount"] as? Int
        author = pointObject["author"] as! PFUser?
        name = pointObject["name"] as? String ?? ""
        profilePicture = loadProfile(name!)
        
        if let userPicture = pointObject.valueForKey("media")! as? PFFile {
            userPicture.getDataInBackgroundWithBlock({
                (imageData: NSData?, error: NSError?) -> Void in
                if (error == nil) {
                    let image = UIImage(data:imageData!)
                    self.tempCell!.pointInTime.image = image
                    self.media = image
                    //self.pointInTime.sizeToFit()
                    print("picture loaded")
                }
            })
        }
    }
    
    func loadProfile(name: String) -> UIImage {
        var posts1: PFObject?
        var tempImage = UIImage()
        let query = PFQuery(className:"Profile")
        query.whereKey("name", equalTo: "\(name)")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects {
                    posts1 = objects[0]
                    print(" loaded profile \(posts1)")
                    
                    if let profile = posts1!.valueForKey("profilePicture")! as? PFFile {
                        profile.getDataInBackgroundWithBlock({
                            (imageData: NSData?, error: NSError?) -> Void in
                            if (error == nil) {
                                let image = UIImage(data:imageData!)
                                self.profilePicture = image
                                self.tempCell!.profilePicture.image = image
                                tempImage = image!
                                print("Profile Picture Loaded")
                            }
                        })
                    }

                }
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
                tempImage = UIImage()
            }
        }
     return tempImage
    }
    
}

