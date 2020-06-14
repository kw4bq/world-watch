//
//  TinyTableViewController.swift
//  test3
//
//  Created by emery on 6/13/20.
//  Copyright © 2020 emery. All rights reserved.
//

import UIKit

class TinyTableViewController: UITableViewController, UINavigationControllerDelegate {

    
    var result: [String: [String: [String]]] = [:]
    var selectedBig: String = ""
    var tiny = [String]()
    var smallmeals = [Meal]()
    var meal: Meal?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    //MARK: Private Methods
    
    private func zoneForName(searchString: String) -> [String] {
        return TimeZone.knownTimeZoneIdentifiers.filter({(item: String) -> Bool in

            let stringMatch = item.lowercased().range(of: searchString.lowercased())
            return stringMatch != nil ? true : false
        })
    }
    
    private func search(key:String, in dict:[String:Any], completion:((Any) -> ())) {
        if let foundValue = dict[key] {
            completion(foundValue)
        } else {
            dict.values.enumerated().forEach {
                if let innerDict = $0.element as? [String:Any] {
                    search(key: key, in: innerDict, completion: completion)
                }
            }
        }
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
        
        var tinies: () = search(key: small, in: result, completion: { print($0) })
        
        tiny.append(tinies)
        //tiny.append(contentsOf: result[small]!.keys.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending })
        
        for city in tiny {
            let search = zoneForName(searchString: city)
            
            let tz = TimeZone(identifier: search[0])
            
            guard let meal = Meal(city: city, timezone: tz?.abbreviation() ?? "oops") else {
                fatalError("Unable to instantiate meal")
            }
            smallmeals += [meal]
        }
        
    }
}
