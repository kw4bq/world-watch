//
//  Meal.swift
//  test3
//
//  Created by emery on 6/12/20.
//  Copyright © 2020 emery. All rights reserved.
//

import UIKit
import os.log


class Meal: NSObject, NSCoding  {
       
    //MARK: Properties
    
    var city: String
    var timezone: String
    
    //MARK: Archiving Paths
     
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    //MARK: Types
     
    struct PropertyKey {
        static let city = "city"
        static let timezone = "timezone"
    }
    
    //MARK: Initialization
     
    init?(city: String, timezone: String) {
        // Initialization should fail if there is no name or if the rating is negative.
        if city.isEmpty || timezone.isEmpty  {
            return nil
        }
        
        self.city = city
        self.timezone = timezone
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(city, forKey: PropertyKey.city)
        aCoder.encode(timezone, forKey: PropertyKey.timezone)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let city = aDecoder.decodeObject(forKey: PropertyKey.city) as? String else {
            os_log("Unable to decode the city for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let timezone = aDecoder.decodeObject(forKey: PropertyKey.timezone) as? String else {
            os_log("Unable to decode the timezone for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer.
        self.init(city: city, timezone: timezone)
    }
    
}
