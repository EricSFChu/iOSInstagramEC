//
//  PointsInTimeViewController.swift
//  PointInTime
//
//  Created by EricDev on 3/3/16.
//  Copyright © 2016 EricDev. All rights reserved.
//

import UIKit
import Parse

class PointsInTimeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    var posts: [PFObject]!
    var name = PFUser.currentUser()!.username!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        //print(posts)
        print(name)
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        posts = loadPointsInTime()
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = posts {
            return posts.count
        }
        else {
            return 0
        }
    }
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("pointsInTime", forIndexPath: indexPath) as! PointInTimeCell
        let post = posts[indexPath.row]
        print(post, " This is the post!")
        cell.pointsObject = post

        //cell.pointInTime.image = post["media"] as? UIImage
        return cell
    }
    
    
    func loadPointsInTime() -> [PFObject]? {
    
        var posts1: [PFObject]?
        let query = PFQuery(className:"Post")
        //query.whereKey("name", equalTo: "\(name)")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            posts1 = objects
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) Points In Time.")
                self.posts = objects
                self.tableView.reloadData()
                
            if let objects = objects {
                    for object in objects {
                        print(object.objectId)
                        print(object)
                    }
            }
            
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        return posts1
    }

}