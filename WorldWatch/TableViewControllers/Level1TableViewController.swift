//
//  Level1TableViewController.swift
//  World Watch
//
//  Created by emery on 6/13/20.
//  Copyright © 2020 emery. All rights reserved.
//

import UIKit
import os.log


class Level1TableViewController: UITableViewController, UINavigationControllerDelegate {

    //MARK: Properties
    
    //var result: [String: [String: [String]]] = [:]
    let root = Node("")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = false

        loadTimeZoneData()
    }

    //MARK: Actions
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        let isPresenting = presentingViewController is UINavigationController
        
        if isPresenting {
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
        
        return root.children.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let l1node = root.children[indexPath.row]
        
        if l1node.children.count > 0 {
            
            let cellIdentifier = "Level1TableViewCell"
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? Level1TableViewCell  else {
                fatalError("The dequeued cell is not an instance of Level1TableViewCell.")
            }
                                
            cell.timezoneTextLabel.text = l1node.value
            cell.accessoryType = .disclosureIndicator
            
            return cell
            
        } else {
            
            let cellIdentifier = "Level1TableViewCellGMT"
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? Level1TableViewCell  else {
                fatalError("The dequeued cell is not an instance of Level1TableViewCell.")
            }
                                
            cell.timezoneTextLabel.text = l1node.value
            cell.accessoryType = .disclosureIndicator
            
            return cell
            
        }
    }

    //MARK: Private Methods
    
    private func loadTimeZoneData() {

        let ids = TimeZone.knownTimeZoneIdentifiers
        for id in ids {
            var node = root
            let splits = id.split(separator: "/").map(String.init)
            for split in splits {
                if let child = node.children.first(where:{$0.value == split}) {
                    node = child
                } else {
                    let newnode = Node(split)
                    node.add(newnode)
                    node = newnode
                }
            }
        }
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "Level2Segue":
            
            guard let level2TableViewController = segue.destination as? Level2TableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedBigCell = sender as? Level1TableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedBigCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            level2TableViewController.selectedL1IndexPath = indexPath
            level2TableViewController.root = root
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }


}
