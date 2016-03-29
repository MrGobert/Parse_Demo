//
//  ViewController.swift
//  Parse_Demo
//
//  Created by James Gobert on 3/24/16.
//  Copyright © 2016 EverydayDigitals. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import pop

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    @IBOutlet weak var logoOneConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var logoTwoContraint: NSLayoutConstraint!
    
    
    var longInViewController: PFLogInViewController! = PFLogInViewController()
    var signUpViewController: PFSignUpViewController! = PFSignUpViewController()
    var animationEngine: AnimationEngine!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.animationEngine = AnimationEngine(constraints: [logoOneConstraint, logoTwoContraint])
        
        
        Parse.initializeWithConfiguration(ParseClientConfiguration(block: { (configuration:ParseMutableClientConfiguration) -> Void in
            configuration.server = "https://parse-demo-app.herokuapp.com/parse"
            configuration.applicationId = "JAMES_APPID"
            configuration.clientKey = "MASTER_UNLOCK_KEY"
        }))
        
   
  }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.animationEngine.animateOnScreen(1)
        
        if (PFUser.currentUser() == nil) {
            self.longInViewController.fields = [PFLogInFields.UsernameAndPassword, PFLogInFields.LogInButton, PFLogInFields.SignUpButton, PFLogInFields.PasswordForgotten, PFLogInFields.DismissButton]
            
            let logInLogoTitle = UILabel()
            logInLogoTitle.text = "Mobile First Studios"
            
            self.longInViewController.logInView!.logo = logInLogoTitle
            
            self.longInViewController.delegate = self
            
            let signUpLogoTitle = UILabel()
            signUpLogoTitle.text = "Mobile First Studios"
            
            self.signUpViewController.signUpView!.logo = signUpLogoTitle
            self.signUpViewController.delegate = self
            self.longInViewController.signUpController = self.signUpViewController
            
            
        } else {
            
            performSegueWithIdentifier("signedin", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Parse Login

    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        
        if (!username.isEmpty || !password.isEmpty) {
            return true
        } else {
            return false
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        print("Failed to login")
    }
    
    
    
    //Parse Sign Up
    
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        print("Failed to Sign up...")
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        print("User dismissed sign up.")
    }
    
    
    
    //Actions
    
    @IBAction func simpleAction(sender: AnyObject) {
        self.presentViewController(self.longInViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func customSignIn(sender: AnyObject) {
        
        self.performSegueWithIdentifier("custom", sender: self)
        
    }
    
    
}

