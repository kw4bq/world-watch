//
//  WorldWatchTableViewController.swift
//  test3
//
//  Created by emery on 6/12/20.
//  Copyright © 2020 emery. All rights reserved.
//

import UIKit
import os.log


class WorldWatchTableViewController: UITableViewController {
    
    //MARK: Properties
     
    @IBOutlet var worldWatchTableView: UITableView!
    
    var locations: [TZIdLocation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Reload tableview data every 2 seconds
        _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
            self.worldWatchTableView.reloadData()
        }
        
        self.worldWatchTableView.allowsSelection = false
        self.worldWatchTableView.allowsSelectionDuringEditing = false
        
        // Use the edit button item provided by the table view controller.
        //navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved locations, otherwise load sample data.
        if let savedLocations = loadLocations() {
            locations += savedLocations
        } else {
            // Load the sample data.
            loadSampleLocations()
        }
        sortLocations()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return locations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        
        let cellIdentifier = "WorldWatchTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? WorldWatchTableViewCell  else {
            fatalError("The dequeued cell is not an instance of WorldWatchTableViewCell.")
        }
        
        // Fetches the appropriate location for the data source layout.
        let location = locations[indexPath.row]
        
        let gmtOffset = location.getGMTOffset() ?? "N/A"
        let localOffset = location.getLocalOffsetFromTZ() ?? "N/A"
        
        cell.cityLabel.text = location.city
        cell.dateLabel.text = location.getCurrentDateWithTimeZone()
        cell.offsetsLabel.text = "Local" + localOffset
        cell.gmtOffset.text = "GMT" + gmtOffset
        cell.timeLabel.text = location.getCurrentTimeWithTimeZone() ?? "N/A"
        cell.standardNameLabel.text = location.getName() ?? "N/A"
                
        let hour: Int = location.getCurrentHourWithTimeZone()!
                
        switch hour {
        case 0:
            cell.contentView.backgroundColor = UIColor(named: "050")
            cell.iconImageView.image = UIImage(named: "00")
            cell.cityLabel.textColor = .white
            cell.dateLabel.textColor = .white
            cell.timeLabel.textColor = .white
            cell.gmtOffset.textColor = .white
            cell.offsetsLabel.textColor = .white
            cell.standardNameLabel.textColor = .white
        case 1:
            cell.contentView.backgroundColor = UIColor(named: "050")
            cell.iconImageView.image = UIImage(named: "01")
            cell.cityLabel.textColor = .white
            cell.dateLabel.textColor = .white
            cell.timeLabel.textColor = .white
            cell.gmtOffset.textColor = .white
            cell.offsetsLabel.textColor = .white
            cell.standardNameLabel.textColor = .white
        case 2:
            cell.contentView.backgroundColor = UIColor(named: "050")
            cell.iconImageView.image = UIImage(named: "02")
            cell.cityLabel.textColor = .white
            cell.dateLabel.textColor = .white
            cell.timeLabel.textColor = .white
            cell.gmtOffset.textColor = .white
            cell.offsetsLabel.textColor = .white
            cell.standardNameLabel.textColor = .white
        case 3:
            cell.contentView.backgroundColor = UIColor(named: "050")
            cell.iconImageView.image = UIImage(named: "03")
            cell.cityLabel.textColor = .white
            cell.dateLabel.textColor = .white
            cell.timeLabel.textColor = .white
            cell.gmtOffset.textColor = .white
            cell.offsetsLabel.textColor = .white
            cell.standardNameLabel.textColor = .white
        case 4:
            cell.contentView.backgroundColor = UIColor(named: "100")
            cell.iconImageView.image = UIImage(named: "04")
            cell.cityLabel.textColor = .white
            cell.dateLabel.textColor = .white
            cell.timeLabel.textColor = .white
            cell.gmtOffset.textColor = .white
            cell.offsetsLabel.textColor = .white
            cell.standardNameLabel.textColor = .white
        case 5:
            cell.contentView.backgroundColor = UIColor(named: "100")
            cell.iconImageView.image = UIImage(named: "05")
            cell.cityLabel.textColor = .white
            cell.dateLabel.textColor = .white
            cell.timeLabel.textColor = .white
            cell.gmtOffset.textColor = .white
            cell.offsetsLabel.textColor = .white
            cell.standardNameLabel.textColor = .white
        case 6:
            cell.contentView.backgroundColor = UIColor(named: "150")
            cell.iconImageView.image = UIImage(named: "06")
            cell.cityLabel.textColor = .black
            cell.dateLabel.textColor = .black
            cell.timeLabel.textColor = .black
            cell.gmtOffset.textColor = .black
            cell.offsetsLabel.textColor = .black
            cell.standardNameLabel.textColor = .black
        case 7:
            cell.contentView.backgroundColor = UIColor(named: "150")
            cell.iconImageView.image = UIImage(named: "07")
            cell.cityLabel.textColor = .black
            cell.dateLabel.textColor = .black
            cell.timeLabel.textColor = .black
            cell.gmtOffset.textColor = .black
            cell.offsetsLabel.textColor = .black
            cell.standardNameLabel.textColor = .black
        case 8:
            cell.contentView.backgroundColor = UIColor(named: "200")
            cell.iconImageView.image = UIImage(named: "08")
            cell.cityLabel.textColor = .black
            cell.dateLabel.textColor = .black
            cell.timeLabel.textColor = .black
            cell.gmtOffset.textColor = .black
            cell.offsetsLabel.textColor = .black
            cell.standardNameLabel.textColor = .black
        case 9:
            cell.contentView.backgroundColor = UIColor(named: "200")
            cell.iconImageView.image = UIImage(named: "09")
            cell.cityLabel.textColor = .black
            cell.dateLabel.textColor = .black
            cell.timeLabel.textColor = .black
            cell.gmtOffset.textColor = .black
            cell.offsetsLabel.textColor = .black
            cell.standardNameLabel.textColor = .black
        case 10:
            cell.contentView.backgroundColor = UIColor(named: "225")
            cell.iconImageView.image = UIImage(named: "10")
            cell.cityLabel.textColor = .black
            cell.dateLabel.textColor = .black
            cell.timeLabel.textColor = .black
            cell.gmtOffset.textColor = .black
            cell.offsetsLabel.textColor = .black
            cell.standardNameLabel.textColor = .black
        case 11:
            cell.contentView.backgroundColor = UIColor(named: "225")
            cell.iconImageView.image = UIImage(named: "11")
            cell.cityLabel.textColor = .black
            cell.dateLabel.textColor = .black
            cell.timeLabel.textColor = .black
            cell.gmtOffset.textColor = .black
            cell.offsetsLabel.textColor = .black
            cell.standardNameLabel.textColor = .black
        case 12:
            cell.contentView.backgroundColor = UIColor(named: "225")
            cell.iconImageView.image = UIImage(named: "12")
            cell.cityLabel.textColor = .black
            cell.dateLabel.textColor = .black
            cell.timeLabel.textColor = .black
            cell.gmtOffset.textColor = .black
            cell.offsetsLabel.textColor = .black
            cell.standardNameLabel.textColor = .black
        case 13:
            cell.contentView.backgroundColor = UIColor(named: "225")
            cell.iconImageView.image = UIImage(named: "13")
            cell.cityLabel.textColor = .black
            cell.dateLabel.textColor = .black
            cell.timeLabel.textColor = .black
            cell.gmtOffset.textColor = .black
            cell.offsetsLabel.textColor = .black
            cell.standardNameLabel.textColor = .black
        case 14:
            cell.contentView.backgroundColor = UIColor(named: "225")
            cell.iconImageView.image = UIImage(named: "14")
            cell.cityLabel.textColor = .black
            cell.dateLabel.textColor = .black
            cell.timeLabel.textColor = .black
            cell.gmtOffset.textColor = .black
            cell.offsetsLabel.textColor = .black
            cell.standardNameLabel.textColor = .black
        case 15:
            cell.contentView.backgroundColor = UIColor(named: "250")
            cell.iconImageView.image = UIImage(named: "15")
            cell.cityLabel.textColor = .black
            cell.dateLabel.textColor = .black
            cell.timeLabel.textColor = .black
            cell.gmtOffset.textColor = .black
            cell.offsetsLabel.textColor = .black
            cell.standardNameLabel.textColor = .black
        case 16:
            cell.contentView.backgroundColor = UIColor(named: "250")
            cell.iconImageView.image = UIImage(named: "16")
            cell.cityLabel.textColor = .black
            cell.dateLabel.textColor = .black
            cell.timeLabel.textColor = .black
            cell.gmtOffset.textColor = .black
            cell.offsetsLabel.textColor = .black
            cell.standardNameLabel.textColor = .black
        case 17:
            cell.contentView.backgroundColor = UIColor(named: "250")
            cell.iconImageView.image = UIImage(named: "17")
            cell.cityLabel.textColor = .black
            cell.dateLabel.textColor = .black
            cell.timeLabel.textColor = .black
            cell.gmtOffset.textColor = .black
            cell.offsetsLabel.textColor = .black
            cell.standardNameLabel.textColor = .black
        case 18:
            cell.contentView.backgroundColor = UIColor(named: "250")
            cell.iconImageView.image = UIImage(named: "18")
            cell.cityLabel.textColor = .black
            cell.dateLabel.textColor = .black
            cell.timeLabel.textColor = .black
            cell.gmtOffset.textColor = .black
            cell.offsetsLabel.textColor = .black
            cell.standardNameLabel.textColor = .black
        case 19:
            cell.contentView.backgroundColor = UIColor(named: "300")
            cell.iconImageView.image = UIImage(named: "19")
            cell.cityLabel.textColor = .black
            cell.dateLabel.textColor = .black
            cell.timeLabel.textColor = .black
            cell.gmtOffset.textColor = .black
            cell.offsetsLabel.textColor = .black
            cell.standardNameLabel.textColor = .black
        case 20:
            cell.contentView.backgroundColor = UIColor(named: "300")
            cell.iconImageView.image = UIImage(named: "20")
            cell.cityLabel.textColor = .black
            cell.dateLabel.textColor = .black
            cell.timeLabel.textColor = .black
            cell.gmtOffset.textColor = .black
            cell.offsetsLabel.textColor = .black
            cell.standardNameLabel.textColor = .black
        case 21:
            cell.contentView.backgroundColor = UIColor(named: "350")
            cell.iconImageView.image = UIImage(named: "21")
            cell.cityLabel.textColor = .white
            cell.dateLabel.textColor = .white
            cell.timeLabel.textColor = .white
            cell.gmtOffset.textColor = .white
            cell.offsetsLabel.textColor = .white
            cell.standardNameLabel.textColor = .white
        case 22:
            cell.contentView.backgroundColor = UIColor(named: "350")
            cell.iconImageView.image = UIImage(named: "22")
            cell.cityLabel.textColor = .white
            cell.dateLabel.textColor = .white
            cell.timeLabel.textColor = .white
            cell.gmtOffset.textColor = .white
            cell.offsetsLabel.textColor = .white
            cell.standardNameLabel.textColor = .white
        case 23:
            cell.contentView.backgroundColor = UIColor(named: "050")
            cell.iconImageView.image = UIImage(named: "23")
            cell.cityLabel.textColor = .white
            cell.dateLabel.textColor = .white
            cell.timeLabel.textColor = .white
            cell.gmtOffset.textColor = .white
            cell.offsetsLabel.textColor = .white
            cell.standardNameLabel.textColor = .white
        default:
            cell.contentView.backgroundColor = .white
            cell.iconImageView.image = UIImage(named: "21")
            cell.cityLabel.textColor = .white
            cell.dateLabel.textColor = .white
            cell.timeLabel.textColor = .white
            cell.gmtOffset.textColor = .white
            cell.offsetsLabel.textColor = .white
            cell.standardNameLabel.textColor = .white
        }

        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            locations.remove(at: indexPath.row)
            saveLocations()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        
        case "ShowDetail":
            
            guard let regionDetailViewController = segue.destination as? DetailViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedCell = sender as? WorldWatchTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedLocation = locations[indexPath.row]
            regionDetailViewController.location = selectedLocation
            
        case "AddItem":
            break
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    
    
    //MARK: Actions
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? DetailViewController, let location = sourceViewController.location {

            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update
                locations[selectedIndexPath.row] = location
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // Add
                let newIndexPath = IndexPath(row: locations.count, section: 0)
                
                locations.append(location)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            saveLocations()
            
        } else if let sourceViewController = sender.source as? Level2TableViewController, let location = sourceViewController.location {

            let newIndexPath = IndexPath(row: locations.count, section: 0)
            
            locations.append(location)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
            saveLocations()
            
        } else if let sourceViewController = sender.source as? Level3TableViewController, let location = sourceViewController.location {

            let newIndexPath = IndexPath(row: locations.count, section: 0)
            
            locations.append(location)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
            saveLocations()
        }
    }
    

    //MARK: Private Methods
     
    private func loadSampleLocations() {

        guard let Auckland = TZIdLocation(city: "Auckland", timezone: "Pacific/Auckland") else {
            fatalError("Unable to instantiate Auckland")
        }
        guard let Sydney = TZIdLocation(city: "Sydney", timezone: "Australia/Sydney") else {
            fatalError("Unable to instantiate Sydney")
        }
        guard let Tokyo = TZIdLocation(city: "Tokyo", timezone: "Asia/Tokyo") else {
            fatalError("Unable to instantiate Tokyo")
        }
        guard let Taipei = TZIdLocation(city: "Taipei", timezone: "Asia/Taipei") else {
            fatalError("Unable to instantiate Taipei")
        }
        guard let Jakarta = TZIdLocation(city: "Jakarta", timezone: "Asia/Jakarta") else {
            fatalError("Unable to instantiate Jakarta")
        }
        guard let Dhaka = TZIdLocation(city: "Dhaka", timezone: "Asia/Dhaka") else {
            fatalError("Unable to instantiate Dhaka")
        }
        guard let Calcutta = TZIdLocation(city: "Calcutta", timezone: "Asia/Calcutta") else {
            fatalError("Unable to instantiate Calcutta")
        }
        guard let Dubai = TZIdLocation(city: "Dubai", timezone: "Asia/Dubai") else {
            fatalError("Unable to instantiate Dubai")
        }
        guard let Moscow = TZIdLocation(city: "Moscow", timezone: "Europe/Moscow") else {
            fatalError("Unable to instantiate Moscow")
        }
        guard let Johannesburg = TZIdLocation(city: "Johannesburg", timezone: "Africa/Johannesburg") else {
            fatalError("Unable to instantiate Johannesburg")
        }
        guard let London = TZIdLocation(city: "London", timezone: "Europe/London") else {
            fatalError("Unable to instantiate London")
        }
        guard let UTC = TZIdLocation(city: "UTC", timezone: "Africa/Banjul") else {
            fatalError("Unable to instantiate UTC")
        }
        guard let Halifax = TZIdLocation(city: "Halifax", timezone: "America/Halifax") else {
            fatalError("Unable to instantiate Halifax")
        }
        guard let New_York = TZIdLocation(city: "New_York", timezone: "America/New_York") else {
            fatalError("Unable to instantiate New_York")
        }
        guard let Chicago = TZIdLocation(city: "Chicago", timezone: "America/Chicago") else {
            fatalError("Unable to instantiate Chicago")
        }
        guard let Denver = TZIdLocation(city: "Denver", timezone: "America/Denver") else {
            fatalError("Unable to instantiate Denver")
        }
        guard let Los_Angeles = TZIdLocation(city: "Los_Angeles", timezone: "America/Los_Angeles") else {
            fatalError("Unable to instantiate Los_Angeles")
        }
        guard let Anchorage = TZIdLocation(city: "Anchorage", timezone: "America/Anchorage") else {
            fatalError("Unable to instantiate Anchorage")
        }
        guard let Honolulu = TZIdLocation(city: "Honolulu", timezone: "Pacific/Honolulu") else {
            fatalError("Unable to instantiate Honolulu")
        }
        
        locations += [Auckland, Sydney, Tokyo, Taipei, Jakarta, Dhaka, Calcutta, Dubai, Moscow, Johannesburg, London, UTC, Halifax, New_York, Chicago, Denver, Los_Angeles, Anchorage, Honolulu]
    }
    
    private func sortLocations() {
        locations = locations.sorted(by: { (one, two) -> Bool in
            if let t1 = one.getGMTOffsetFloat(), let t2 = two.getGMTOffsetFloat() {
                return t1 > t2
            } else {
                return true
            }
        })
    }
    
    private func saveLocations() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(locations, toFile: TZIdLocation.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Location successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save locations...", log: OSLog.default, type: .error)
        }
        sortLocations()
    }
    
    private func loadLocations() -> [TZIdLocation]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: TZIdLocation.ArchiveURL.path) as? [TZIdLocation]
    }
    
    
}
