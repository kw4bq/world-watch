//
//  MealTableViewCell.swift
//  test3
//
//  Created by emery on 6/12/20.
//  Copyright © 2020 emery. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var timezone: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
