//
//  medicationTableViewCell.swift
//  PillTrak+
//
//  Created by Nathan Loew on 10/28/17.
//  Copyright © 2017 Ian Pearson. All rights reserved.
//

import UIKit

class medicationTableViewCell: UITableViewCell {
    //MARK: Properties
    
    @IBOutlet weak var medLabel: UILabel!
    @IBOutlet weak var pillDate: pillDatePicker!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
