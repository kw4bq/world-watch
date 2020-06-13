//
//  CountryStateTableViewController.swift
//  test3
//
//  Created by emery on 6/13/20.
//  Copyright © 2020 emery. All rights reserved.
//

import UIKit

class CountryStateTableViewController: UITableViewController, UINavigationControllerDelegate {

    //MARK: Properties

    var result: [String: [String: [String]]] = [:]
    var selectedBig: String = ""
    var small = [String]()
    
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
        return small.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        
        let cellIdentifier = "CountryStateTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CountryStateTableViewCell  else {
            fatalError("The dequeued cell is not an instance of CountryStateTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let countrystate = small[indexPath.row]
        
        cell.smallTextLabel.text = countrystate
        
        return cell
    }

    //MARK: Private Methods
     
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
        
        small.append(contentsOf: result[big]!.keys)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
