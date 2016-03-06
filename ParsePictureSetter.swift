//
//  ParsePictureSetter.swift
//  PointInTime
//
//  Created by EricDev on 3/5/16.
//  Copyright © 2016 EricDev. All rights reserved.
//

import UIKit
import Parse

class ParsePictureSetter: NSObject {

    var image: UIImage?
    var imageFrame: UIImageView?
    var controller: ProfileViewController?

    
    init(profileObject: PFObject?) {
        super.init()
        
    
        if let userPicture = profileObject!.valueForKey("profilePicture")! as? PFFile {
            userPicture.getDataInBackgroundWithBlock({
                (imageData: NSData?, error: NSError?) -> Void in
                if (error == nil) {
                    let image = UIImage(data:imageData!)
                    self.image = image
                    self.controller?.profilePicture.image = image
                    // self.controller?.reloadInputViews()
                    print("picture loaded")
                }
            })
        }
        
    }
}
