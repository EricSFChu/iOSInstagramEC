//
//  PointInTimeCell.swift
//  PointInTime
//
//  Created by EricDev on 3/3/16.
//  Copyright © 2016 EricDev. All rights reserved.
//

import UIKit
import Parse

class PointInTimeCell: UITableViewCell {

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var pointInTime: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var dateCreated: UILabel!
    
    
     var pointsObject: PFObject! {
        didSet{
            point = PointInTime(pointObject: pointsObject!)
            point.tempCell = self;
        }
    }
    
    var point: PointInTime! {
        didSet{
            pointInTime.image = point.media
            captionLabel.text = point.caption
            dateCreated.text = "\(pointsObject.createdAt!)"
            name.text = point.name
        }
    }
}
