//
//  TimeZonesTableViewController.swift
//  test3
//
//  Created by emery on 6/13/20.
//  Copyright © 2020 emery. All rights reserved.
//

import UIKit
import os.log

class TimeZonesTableViewController: UITableViewController, UINavigationControllerDelegate {

    //MARK: Properties
    
    var result: [String: [String: [String]]] = [:]
    var big = [String]()
         
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
                

        loadTimeZoneData()
    }

    //MARK: Actions
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        os_log("Cancelling.", log: OSLog.default, type: .debug)
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The TimeZonesTableViewController is not inside a navigation controller.")
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return big.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        
        let cellIdentifier = "TimeZoneTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TimeZoneTableViewCell  else {
            fatalError("The dequeued cell is not an instance of TimeZoneTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        
        let region = big[indexPath.row]
        
        cell.timezoneTextLabel.text = region
        
        return cell
    }

    //MARK: Private Methods
    
    private func loadTimeZoneData() {

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
        
        big.append(contentsOf: result.keys)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "CountryState":
            
            os_log("Show Small.", log: OSLog.default, type: .debug)
            guard let countryStateTableViewController = segue.destination as? CountryStateTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedBigCell = sender as? TimeZoneTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedBigCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedBig = big[indexPath.row]
            print(selectedBig)
            countryStateTableViewController.selectedBig = selectedBig
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }


}
