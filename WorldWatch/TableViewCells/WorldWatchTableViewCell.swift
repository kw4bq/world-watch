//
//  WorldWatchTableViewCell.swift
//  World Watch
//
//  Created by emery on 6/12/20.
//  Copyright © 2020 emery. All rights reserved.
//

import UIKit

class WorldWatchTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var abbrLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var standardNameLabel: UILabel!
    @IBOutlet weak var offsetsLabel: UILabel!
    @IBOutlet weak var twelveHourLabel: UILabel!
    @IBOutlet weak var gmtOffset: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
