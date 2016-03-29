//
//  CustomSignUpVC.swift
//  Parse_Demo
//
//  Created by James Gobert on 3/25/16.
//  Copyright © 2016 EverydayDigitals. All rights reserved.
//

import UIKit
import Parse

class CustomSignUpVC: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    var activityInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityInd.center = self.view.center
        
        self.activityInd.hidesWhenStopped = true
        
        self.activityInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        view.addSubview(self.activityInd)
        
        self.passwordField.delegate = self
        self.emailField.delegate = self
        self.usernameField.delegate = self
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signUpAction(sender: AnyObject) {
        
        
        let username = self.usernameField.text
        let password = self.passwordField.text
        let email = self.emailField.text
        let okButton = "OK"
        
        if (username?.characters.count < 4 || password?.characters.count < 5) {
            
            let alert = UIAlertController(title: "Invalid", message: "Username must be at least 5 character and Password at least 6", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: okButton, style: .Default, handler: nil)
            
            alert.addAction(okAction)
            
            presentViewController(alert, animated: true, completion: nil)
            
        } else if (email?.characters.count < 8) {
            
            let alert = UIAlertController(title: "Invalid", message: "Please enter a vaild email address", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: okButton, style: .Default, handler: nil)
            
            alert.addAction(okAction)
            
            presentViewController(alert, animated: true, completion: nil)
            
        } else {
            
            
            self.activityInd.startAnimating()
            
            let newUser = PFUser()
            
            newUser.username = username
            newUser.password = password
            newUser.email = email
            
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                
                self.activityInd.stopAnimating()
                
                if ((error) == nil) {
                    
                    let alert = UIAlertController(title: "Success", message: "You've created an account, please login in", preferredStyle: .Alert)
                    let okAction = UIAlertAction(title: okButton, style: .Default, handler: nil)
                    
                    alert.addAction(okAction)
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("mainvc")
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })
                    
                } else {
                    
                    let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .Alert)
                    let okAction = UIAlertAction(title: okButton, style: .Default, handler: nil)
                    
                    alert.addAction(okAction)
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                }
            })
            
        }
        
    }
    
    @IBAction func closeBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
