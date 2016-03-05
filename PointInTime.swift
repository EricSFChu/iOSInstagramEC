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
    
    init(pointObject: PFObject) {
        super.init()
        tempCell = PointInTimeCell()
        print("This is it \(pointObject)")
        caption = pointObject["caption"] as? String
        //tempCell!.captionLabel.text = caption
        likesCount = pointObject["likesCount"] as? Int
        commentsCount = pointObject["commentsCount"] as? Int
        author = pointObject["author"] as! PFUser?
        name = pointObject["name"] as? String
        
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
    
}

