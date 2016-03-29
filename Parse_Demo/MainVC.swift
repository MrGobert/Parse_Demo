//
//  MainVC.swift
//  Parse_Demo
//
//  Created by James Gobert on 3/25/16.
//  Copyright © 2016 EverydayDigitals. All rights reserved.
//

import UIKit
import Parse

class MainVC: UIViewController {
    
    
    @IBOutlet weak var activeUserName: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let pUserName = PFUser.currentUser()?["username"] as? String {
            self.activeUserName.text = "Hello @\(pUserName)!"
        }
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if (PFUser.currentUser() == nil) {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
                self.presentViewController(viewController, animated: true, completion: nil)
            })
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    

    @IBAction func logoutPressed(sender: UIButton) {
        
        PFUser.logOut()
        
    }

    @IBAction func unwindForSegue(unwindSegue: UIStoryboardSegue) {
        
    }

}
