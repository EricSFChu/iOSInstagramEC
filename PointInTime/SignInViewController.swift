//
//  SignInViewController.swift
//  PointInTime
//
//  Created by EricDev on 2/29/16.
//  Copyright © 2016 EricDev. All rights reserved.
//

import UIKit
import Parse

class SignInViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var user: PFUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
    }
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() != nil {
            self.performSegueWithIdentifier("loggedInSegue", sender: nil)
        }
    }
    override func viewWillAppear(animated: Bool) {

    }

    @IBAction func onSignIn(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(userName.text!, password: password.text!) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("Sign in success")
                self.performSegueWithIdentifier("loggedInSegue", sender: nil)
                //let upcomingNavigationController = self.storyboard!.instantiateViewControllerWithIdentifier("loggedInView") as! UITabBarController
                //upcomingNavigationController.presentedViewController

            
            } else {
                print("Sign in failed: \(error)")
                if error?.code == 101 {
                    print("Invalid username/password")
                }
            }
            
        }
        
    }
    

    @IBAction func onSignUp(sender: AnyObject) {
        
        let newUser = PFUser()
        
        newUser.username = userName.text
        newUser.password = password.text
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
        
            if success {
                print("Successfully signed up")
                self.performSegueWithIdentifier("loggedInSegue", sender: nil)
               // NSUserDefaults.standardUserDefaults().setObject(self.user, forKey: "user")
            } else {
                print("Failed to sign up: \(error)")
                if error?.code == 202 {
                    print("Error account name already taken")
                }
            }
        }
    }
}
