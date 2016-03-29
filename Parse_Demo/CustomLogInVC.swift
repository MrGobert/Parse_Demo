//
//  CustomLogInVC.swift
//  Parse_Demo
//
//  Created by James Gobert on 3/25/16.
//  Copyright © 2016 EverydayDigitals. All rights reserved.
//

import UIKit
import Parse

class CustomLogInVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordfield: UITextField!
    
    var activityInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.activityInd.center = self.view.center
        
        self.activityInd.hidesWhenStopped = true
        
        self.activityInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        view.addSubview(self.activityInd)
        
        self.passwordfield.delegate = self
        self.usernameField.delegate = self
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    
    
    // Actions

    @IBAction func longAction(sender: AnyObject) {
        
        let username = self.usernameField.text
        let password = self.passwordfield.text
        
        let okButton = "OK"
        
        if (username?.characters.count < 4 || password?.characters.count < 5) {
            
            let alert = UIAlertController(title: "Invalid", message: "Username must be at least 5 character and Password at least 6", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: okButton, style: .Default, handler: nil)
            
            alert.addAction(okAction)
            presentViewController(alert, animated: true, completion: nil)
            
        } else {
            
            self.activityInd.startAnimating()
            
            PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) -> Void in
                
                self.activityInd.stopAnimating()
                
                if ((user) != nil) {
                    
                    let alert = UIAlertController(title: "Success", message: "Logged In", preferredStyle: .Alert)
                    let okAction = UIAlertAction(title: okButton, style: .Default, handler: nil)
                    
                    alert.addAction(okAction)
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("mainvc")
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })
                    
                } else {
                    
                    let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .Alert)
                    let okAction = UIAlertAction(title: okButton, style: .Default, handler: nil)
                    
                    alert.addAction(okAction)
                    
                }
            })
            
        }
        
    }


    @IBAction func signupAction(sender: AnyObject) {
        
        self.performSegueWithIdentifier("signup", sender: self)
    
        
    }
    
    @IBAction func closeBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
