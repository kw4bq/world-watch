//
//  CountryStateTableViewController.swift
//  test3
//
//  Created by emery on 6/13/20.
//  Copyright © 2020 emery. All rights reserved.
//

import UIKit
import os.log

class CountryStateTableViewController: UITableViewController, UINavigationControllerDelegate {

    //MARK: Properties

    var result: [String: [String: [String]]] = [:]
    var selectedBig: String = ""
    var small = [String]()
    var smallmeals = [Meal]()
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        loadTimeZoneData(big: selectedBig)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return smallmeals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        
        let countrystate = smallmeals[indexPath.row]
        
        if countrystate.timezone == "-------" {
            
            let cellIdentifier = "CityNestedTableViewCell"
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CityNestedTableViewCell  else {
                fatalError("The dequeued cell is not an instance of CityNestedTableViewCell.")
            }
            
            // Fetches the appropriate meal for the data source layout.
            cell.cityNestedTextLabel.text = countrystate.city
            cell.accessoryType = .disclosureIndicator
            
            return cell
        } else {
            
            let cellIdentifier = "CountryStateTableViewCell"
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CountryStateTableViewCell  else {
                fatalError("The dequeued cell is not an instance of CountryStateTableViewCell.")
            }
            
            // Fetches the appropriate meal for the data source layout.
            cell.smallTextLabel.text = countrystate.city
            cell.timeZoneIdTextLabel.text = countrystate.timezone
            
            return cell
        }
        
    }
    
    //MARK: Private Methods
    
    private func zoneForName(searchString: String) -> [String] {
        return TimeZone.knownTimeZoneIdentifiers.filter({(item: String) -> Bool in

            let stringMatch = item.lowercased().range(of: searchString.lowercased())
            return stringMatch != nil ? true : false
        })
    }
    
    private func loadTimeZoneData(big: String) {

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
        
        small.append(contentsOf: result[big]!.keys.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending })
        
        for city in small {
            let search = zoneForName(searchString: city)
            if search.count == 1 {
                let tz = TimeZone(identifier: search[0])
                
                guard let meal = Meal(city: city, timezone: tz?.abbreviation() ?? "oops") else {
                    fatalError("Unable to instantiate meal")
                }
                smallmeals += [meal]
            } else {
                guard let meal = Meal(city: city, timezone: "-------") else {
                    fatalError("Unable to instantiate meal")
                }
                smallmeals += [meal]
            }
        }
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        os_log("Show Small.", log: OSLog.default, type: .debug)

        switch(segue.identifier ?? "") {
          
        case "UnwindSmallToMeal":
            guard let selectedSmallCell = sender as? CountryStateTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedSmallCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedSmall = smallmeals[indexPath.row]
            print(selectedSmall)
            //countryStateTableViewController.selectedBig = selectedBig
            
            let city = selectedSmallCell.smallTextLabel.text ?? ""
            let tzlabel = selectedSmallCell.timeZoneIdTextLabel.text ?? ""
            
            // Set the meal to be passed to MealTableViewController after the unwind segue.
            meal = Meal(city: city, timezone: tzlabel)
            
        case "TinySegue":
            
            os_log("Show Small.", log: OSLog.default, type: .debug)
            guard let tinyTableViewController = segue.destination as? TinyTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedTinyCell = sender as? CityNestedTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedTinyCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedSmall = small[indexPath.row]
            print(selectedSmall)
            tinyTableViewController.selectedSmall = selectedSmall
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
        
    }
    

}
