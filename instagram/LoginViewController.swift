//
//  LoginViewController.swift
//  instagram
//
//  Created by Olivia Koshy on 6/20/16.
//  Copyright © 2016 Olivia Koshy. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {


    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    
    var username: String?
        

        // Do any additional setup after loading the view.
    }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignUp(sender: AnyObject) {
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if let error = error {
                print(error.localizedDescription)
                if error.code == 202 {
                    print("Username is already taken :(")
                    
                }
            } else {
                print("User Registered successfully")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
                // manually segue to logged in view
            }
        }
    }
    @IBAction func onSignIn(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!){
            (user: PFUser? , error: NSError?) -> Void in
            if user != nil {
                print("You're Logged in!")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
                
            }
        }
    }
        
//    @IBAction func onSignOut(sender: AnyObject) {
//        print("Signing Out")
//        PFUser.logOutInBackgroundWithBlock { (error: NSError?) in
//            self.performSegueWithIdentifier("logoutSegue", sender: nil)
//            
//    }
    
    
        
   
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

