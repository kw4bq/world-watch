//
//  TinyTableViewController.swift
//  test3
//
//  Created by emery on 6/13/20.
//  Copyright © 2020 emery. All rights reserved.
//

import UIKit
import os.log

extension Dictionary {
    func search(key:String, in dict:[String:Any] = [:]) -> Any? {
        guard var currDict = self as? [String : Any]  else { return nil }
        currDict = !dict.isEmpty ? dict : currDict

        if let foundValue = currDict[key] {
            return foundValue
        } else {
            for val in currDict.values {
                if let innerDict = val as? [String:Any], let result = search(key: key, in: innerDict) {
                    return result
                }
            }
            return nil
        }
    }
}

class TinyTableViewController: UITableViewController, UINavigationControllerDelegate {

    
    var result: [String: [String: [String]]] = [:]
    var selectedSmall: String = ""
    var tiny = [String]()
    var tinymeals = [Meal]()
    var meal: Meal?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTimeZoneData(small: selectedSmall)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tinymeals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.

        let cellIdentifier = "TinyTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TinyTableViewCell  else {
            fatalError("The dequeued cell is not an instance of TinyTableViewCell.")
        }
        
        let tinystate = tinymeals[indexPath.row]

        // Fetches the appropriate meal for the data source layout.
        cell.tinyLabel.text = tinystate.city
        cell.tinyTzIdLabel.text = tinystate.timezone
        
        return cell
            
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        os_log("Show Small.", log: OSLog.default, type: .debug)

        switch(segue.identifier ?? "") {
          
        case "UnwindTinyToMeal":
            guard let selectedTinyCell = sender as? TinyTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedTinyCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedTiny = tinymeals[indexPath.row]
            print(selectedTiny)
            
            let city = selectedTinyCell.tinyLabel.text ?? ""
            let tzlabel = selectedTinyCell.tinyTzIdLabel.text ?? ""
            
            // Set the meal to be passed to MealTableViewController after the unwind segue.
            meal = Meal(city: city, timezone: tzlabel)
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }

    
    
    //MARK: Private Methods
    
    private func zoneForName(searchString: String) -> [String] {
        return TimeZone.knownTimeZoneIdentifiers.filter({(item: String) -> Bool in

            let stringMatch = item.lowercased().range(of: searchString.lowercased())
            return stringMatch != nil ? true : false
        })
    }

    
    private func loadTimeZoneData(small: String) {

        result = TimeZone.knownTimeZoneIdentifiers.reduce(into: [:]) {
            if let index = $1.firstIndex(of: "/") {
                let key = String($1[..<index])
                let value = String($1[$1.index(after: index)...])
                if let index = value.firstIndex(of: "/") {
                    let country = String(value[..<index])
                    let city = String(value[value.index(after: index)...])
                    $0[key, default: [:]][country, default: []].append(city)
                } else {
                    $0[key, default: [:]][value] = []
                }
            }
        }
        
        let tinies: [String] = result.search(key: small) as! [String]
        print("tinies", tinies)
        tiny.append(contentsOf: tinies)
        //tiny.append(contentsOf: result[small]!.keys.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending })
        
        for city in tiny {
            let search = zoneForName(searchString: city)
            
            let tz = TimeZone(identifier: search[0])
            
            guard let meal = Meal(city: city, timezone: tz?.abbreviation() ?? "oops") else {
                fatalError("Unable to instantiate meal")
            }
            tinymeals += [meal]
        }
        
    }
}
