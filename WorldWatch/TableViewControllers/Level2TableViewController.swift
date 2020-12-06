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
    
    var selectedL1IndexPath: IndexPath?
    var location: TZIdLocation?
    var root: Node<String>?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = false
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
        
        if l2node.children.count > 0 {
            
            let cellIdentifier = "Level2AltTableViewCell"
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? Level2AltTableViewCell  else {
                fatalError("The dequeued cell is not an instance of Level2AltTableViewCell.")
            }
            
            cell.cityNestedTextLabel.text = l2node.value
            cell.accessoryType = .disclosureIndicator
            
            return cell
        } else {
            
            let cellIdentifier = "Level2TableViewCell"
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? Level2TableViewCell  else {
                fatalError("The dequeued cell is not an instance of Level2TableViewCell.")
            }
            
            cell.smallTextLabel.text = l2node.value
            cell.timeZoneIdTextLabel.text = l2node.localized()
            
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
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
        
    }
    

}
