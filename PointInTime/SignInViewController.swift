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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func onSignIn(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(userName.text!, password: password.text!) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("Sign in success")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
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
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            } else {
                print("Failed to sign up: \(error)")
                if error?.code == 202 {
                    print("Error account name already taken")
                }
            }
        }
    }
}
