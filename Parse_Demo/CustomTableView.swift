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
    let detailSegueIdentifier = "showDetail"
    
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == detailSegueIdentifier {
            if let destination = segue.destinationViewController as? DetailUserVC {
                if let userIndex = tableview.indexPathForSelectedRow?.row {
                    let object = userArray[userIndex] as! PFObject
                    let name = object["username"] as! String
                    destination.userName = name
                    
                   let emailString = userArray[userIndex] as! PFObject
                    let email = emailString["email"] as! String
                    destination.userEmail = email
                }
            }
        }
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableview.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        print(userArray[row])
    }
   
}
