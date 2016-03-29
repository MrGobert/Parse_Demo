//
//  CustomCell.swift
//  Parse_Demo
//
//  Created by James Gobert on 3/27/16.
//  Copyright © 2016 EverydayDigitals. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    
    
    @IBOutlet weak var userNameLbl: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
