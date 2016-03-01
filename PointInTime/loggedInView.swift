//
//  loggedInView.swift
//  PointInTime
//
//  Created by EricDev on 2/29/16.
//  Copyright © 2016 EricDev. All rights reserved.
//

import UIKit
import Parse

class loggedInView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOut()
        self.dismissViewControllerAnimated(true) { () -> Void in
            print("Logged Out")
        }
    }
}
