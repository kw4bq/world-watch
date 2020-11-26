//
//  CountryStateTableViewCell.swift
//  test3
//
//  Created by emery on 6/13/20.
//  Copyright © 2020 emery. All rights reserved.
//

import UIKit

class Level2TableViewCell: UITableViewCell {

    @IBOutlet weak var smallTextLabel: UILabel!
    @IBOutlet weak var timeZoneIdTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
