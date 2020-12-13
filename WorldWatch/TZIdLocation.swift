//
//  TZIdLocation.swift
//  World Watch
//
//  Created by emery on 6/12/20.
//  Copyright © 2020 emery. All rights reserved.
//

import UIKit
import os.log


class TZIdLocation: NSObject, NSCoding  {
       
    //MARK: Properties
    
    var city: String
    var timezone: String
    
    func getGMTOffsetFloat() -> Float? {
        return Float((TimeZone.init(identifier: self.timezone)?.secondsFromGMT(for: Date()))!) / Float(3600)
    }
    
    func getGMTOffset() -> String? {
        let float: Float = Float((TimeZone.init(identifier: self.timezone)?.secondsFromGMT(for: Date()))!) / Float(3600)
        var str: String = ""
        if abs(float.remainder(dividingBy: 1.0)) == 0.0 {
            str = String(describing: Int(float))
        } else {
            str = String(describing: float)
        }
        if float >= 0.0 {
            str = "+" + str
        }
        // don't need - ??
        return str
    }
    
    func getLocalOffsetFromTZ() -> String? {
        
        let offsetFromGMT: Float = Float(Calendar.current.timeZone.secondsFromGMT() / 60 / 60)

        let float: Float = Float((TimeZone.init(identifier: self.timezone)?.secondsFromGMT(for: Date()))!) / Float(3600)

        let difference: Float = abs(float-offsetFromGMT)
        
        var str: String = ""
        if abs(difference.remainder(dividingBy: 1.0)) == 0.0 {
            // cast to int to get rid of precision
            str = String(describing: Int(difference))
        } else {
            str = String(describing: difference)
        }
        if difference >= 0.0 {
            if offsetFromGMT > float {
                str = "-" + str
            } else {
                str = "+" + str
            }
        }
        return str
    }

    
//    func getAbbr() -> String? {
//        return TimeZone.init(identifier: self.timezone)?.abbreviation()
//    }
    
    // Central Standard Time
    func getName() -> String? {
        let tz = TimeZone.init(identifier: self.timezone)
        if (tz?.isDaylightSavingTime(for: Date()))! {
            return tz?.localizedName(for: .daylightSaving, locale: .current)
        } else {
            return tz?.localizedName(for: .standard, locale: .current)
        }
    }
    
//    func getShortGenericName() -> String? {
//        let tz = TimeZone.init(identifier: self.timezone)
//        return tz?.localizedName(for: .shortGeneric, locale: .current)
//    }
    
//    // CST
//    func getShortName() -> String? {
//        let tz = TimeZone.init(identifier: self.timezone)
//        var str: String? = ""
//        if (tz?.isDaylightSavingTime(for: Date()))! {
//            str = tz?.localizedName(for: .shortDaylightSaving, locale: .current)
//        } else {
//            str = tz?.localizedName(for: .shortStandard, locale: .current)
//        }
//        return str
//    }
    
    func getCurrentTimeWithTimeZone() -> String? {
        let currentDate = Date()
        let format = DateFormatter()
        format.timeZone = TimeZone.init(identifier: self.timezone)
        format.dateFormat = "HH:mm"

        let dateString = format.string(from: currentDate)
        return dateString
    }
    
//    func getCurrentTwelveHourWithTimeZone() -> String? {
//        let currentDate = Date()
//        let format = DateFormatter()
//        format.timeZone = TimeZone.init(identifier: self.timezone)
//        format.dateFormat = "hh:mm a"
//
//        let dateString = format.string(from: currentDate)
//        return dateString
//    }
    
    func getCurrentHourWithTimeZone() -> Int? {
        let currentDate = Date()
        let format = DateFormatter()
        format.timeZone = TimeZone.init(identifier: self.timezone)
        format.dateFormat = "HH"

        let dateString = format.string(from: currentDate)
        return Int(dateString)
    }
    
    func getCurrentDateWithTimeZone() -> String? {
        let currentDate = Date()
        let format = DateFormatter()
        format.timeZone = TimeZone.init(identifier: self.timezone)
        //format.dateFormat = "EEEE, MMM d"
        format.dateFormat = "E, d MMM yyyy"
        
        let dateString = format.string(from: currentDate)
        return dateString
    }
    
    //MARK: Archiving Paths
     
//    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
//    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("timezones")
    
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
            os_log("Unable to decode the city for a TZ object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let timezone = aDecoder.decodeObject(forKey: PropertyKey.timezone) as? String else {
            os_log("Unable to decode the timezone for a TZ object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer.
        self.init(city: city, timezone: timezone)
    }
    
}
