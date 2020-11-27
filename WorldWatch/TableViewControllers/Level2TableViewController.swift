//
//  Level2TableViewController.swift
//  World Watch
//
//  Created by emery on 6/13/20.
//  Copyright © 2020 emery. All rights reserved.
//

import UIKit
import os.log

class Level2TableViewController: UITableViewController, UINavigationControllerDelegate {

    //MARK: Properties

    var result: [String: [String: [String]]] = [:]
    var selectedBig: String = ""
    var selectedL1IndexPath: IndexPath?
    //var small = [String]()
    //var smallRegions = [TZIdLocation]()
    var location: TZIdLocation?
    var root: Node<String>?
    //var level2children: Node<String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        //level2children = root!.children[selectedL1IndexPath!.row].children
        //loadTimeZoneData(selected: selectedBig)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return root!.children[selectedL1IndexPath!.row].children.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let l2node = root!.children[selectedL1IndexPath!.row].children[indexPath.row]
        let l2childHasChildren: Bool = l2node.children.count > 0
        
        if l2childHasChildren {
            
            let cellIdentifier = "Level2AltTableViewCell"
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? Level2AltTableViewCell  else {
                fatalError("The dequeued cell is not an instance of Level2AltTableViewCell.")
            }
            
            // Fetches the appropriate location for the data source layout.
            cell.cityNestedTextLabel.text = l2node.value
            cell.accessoryType = .disclosureIndicator
            
            return cell
        } else {
            
            let cellIdentifier = "Level2TableViewCell"
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? Level2TableViewCell  else {
                fatalError("The dequeued cell is not an instance of Level2TableViewCell.")
            }
            
            // Fetches the appropriate location for the data source layout.
            cell.smallTextLabel.text = l2node.value
            //cell.timeZoneIdTextLabel.text = small.getShortName()
            
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
    
    private func loadTimeZoneData(selected: String) {

        
//        result = TimeZone.knownTimeZoneIdentifiers.reduce(into: [:]) {
//            if let index = $1.firstIndex(of: "/") {
//                let key = String($1[..<index])
//                let value = String($1[$1.index(after: index)...])
//                if let index = value.firstIndex(of: "/") {
//                    let country = String(value[..<index])
//                    let city = String(value[value.index(after: index)...])
//                    $0[key, default: [:]][country, default: []].append(city)
//                } else {
//                    $0[key, default: [:]][value] = []
//                }
//            }
//        }
//
//        small.append(contentsOf: result[big]!.keys.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending })
//
//        for city in small {
//            let search = zoneForName(searchString: city)
//            //print("Searching zone for name", city, search[0])
//            if search.count == 1 {
//                guard let location = TZIdLocation(city: city, timezone: search[0]) else {
//                    fatalError("Unable to instantiate location")
//                }
//                smallRegions += [location]
//            } else {
//                //print("Setting TZ to nil for", city)
//                guard let location = TZIdLocation(city: city, timezone: "-------") else {
//                    fatalError("Unable to instantiate location")
//                }
//                smallRegions += [location]
//            }
//        }
        
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
          
        case "UnwindLevel2ToHome":
            
            guard let selectedLevel2Cell = sender as? Level2TableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedLevel2Cell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            //let selectedSmall = smallRegions[indexPath.row]
            
            //print("Selected small", selectedSmall.city, selectedSmall.timezone)

            //location = TZIdLocation(city: selectedSmall.city, timezone: selectedSmall.timezone)
            
        case "Level3Segue":
            
            guard let level3TableViewController = segue.destination as? Level3TableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedLevel2Cell = sender as? Level2AltTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedLevel2Cell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            level3TableViewController.selectedL1IndexPath = selectedL1IndexPath
            level3TableViewController.selectedL2IndexPath = indexPath
            level3TableViewController.root = root
            //let selectedSmall = small[indexPath.row]
            //print(selectedSmall)
            //tinyTableViewController.selectedSmall = selectedSmall
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
        
    }
    

}
