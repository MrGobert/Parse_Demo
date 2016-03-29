//
//  CustomTableView.swift
//  Parse_Demo
//
//  Created by James Gobert on 3/27/16.
//  Copyright © 2016 EverydayDigitals. All rights reserved.
//

import UIKit
import Parse

class CustomTableView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var userArray: NSMutableArray = []
    
    @IBOutlet weak var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self
        
        loadParseData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func loadParseData() {
        
        let query: PFQuery = PFUser.query()!
        
        query.findObjectsInBackgroundWithBlock {
            
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                if let objects = objects {
                    for object in objects {
                        self.userArray.addObject(object)
                    }
                }
                
                self.tableview.reloadData()
                
            } else {
                
                print("There was an error")
            }
        }
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomCell
        
        let user = userArray[indexPath.row] as! PFUser
        let username = user.username
        cell.userNameLbl.text = "@" + username!
        
        return cell
    }

}
