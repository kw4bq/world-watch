//
//  TimeZoneTableViewCell.swift
//  test3
//
//  Created by emery on 6/13/20.
//  Copyright © 2020 emery. All rights reserved.
//

import UIKit

class TimeZoneTableViewCell: UITableViewCell {

    @IBOutlet weak var timezoneTextLabel: UILabel!
    @IBOutlet weak var timezoneIdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
