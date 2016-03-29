//
//  DetailUserVC.swift
//  Parse_Demo
//
//  Created by James Gobert on 3/29/16.
//  Copyright © 2016 EverydayDigitals. All rights reserved.
//

import UIKit
import Parse

class DetailUserVC: UIViewController {
    
    var userName = String()
    var userEmail = String()
    
    
    @IBOutlet weak var userNameLbl: UILabel!
    
    @IBOutlet weak var userEmailLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        userNameLbl.text = userName
        userEmailLbl.text = userEmail
    }
    
    override func viewDidAppear(animated: Bool) {
        
//        let pUserName = PFUser.currentUser()?["username"] as? String
//        let pUserEmail = PFUser.
//        
//        self.userNameLbl.text = "Username: @\(pUserName)!"

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
