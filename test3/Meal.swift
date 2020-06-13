//
//  Meal.swift
//  test3
//
//  Created by emery on 6/12/20.
//  Copyright © 2020 emery. All rights reserved.
//

import UIKit

class Meal {
    
    //MARK: Properties
    
    var city: String
    var timezone: String
    
    //MARK: Initialization
     
    init?(city: String, timezone: String) {
        // Initialization should fail if there is no name or if the rating is negative.
        if city.isEmpty || timezone.isEmpty  {
            return nil
        }
        
        self.city = city
        self.timezone = timezone
    }
}
