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
    
    var meals = [RegionTimeZone]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Reload tableview data every 2 seconds
        _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
            self.worldWatchTableView.reloadData()
        }
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved meals, otherwise load sample data.
        if let savedMeals = loadMeals() {
            meals += savedMeals
        } else {
            // Load the sample data.
            loadSampleMeals()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        
        let cellIdentifier = "MealTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let meal = meals[indexPath.row]
                
        cell.cityLabel.text = meal.city
        cell.dateLabel.text = meal.getCurrentDateWithTimeZone()
        cell.timeLabel.text = meal.getCurrentTimeWithTimeZone()
        cell.standardNameLabel.text = meal.getName()
        
        let hour: Int = meal.getCurrentHourWithTimeZone()!
        
        switch hour {
        case 0...3:
            cell.contentView.backgroundColor = UIColor(named: "000")
            cell.iconImageView.image = UIImage(named: "zzz")
            cell.cityLabel.textColor = .white
            cell.dateLabel.textColor = .white
            cell.timeLabel.textColor = .white
            cell.standardNameLabel.textColor = .white
        case 4...5:
            cell.contentView.backgroundColor = UIColor(named: "050")
            cell.iconImageView.image = UIImage(named: "rising")
            cell.cityLabel.textColor = .white
            cell.dateLabel.textColor = .white
            cell.timeLabel.textColor = .white
            cell.standardNameLabel.textColor = .white
        case 6...7:
            cell.contentView.backgroundColor = UIColor(named: "100")
            cell.iconImageView.image = UIImage(named: "coffee")
            cell.cityLabel.textColor = .black
            cell.dateLabel.textColor = .black
            cell.timeLabel.textColor = .black
            cell.standardNameLabel.textColor = .black
        case 8...9:
            cell.contentView.backgroundColor = UIColor(named: "200")
            cell.iconImageView.image = UIImage(named: "work")
            cell.cityLabel.textColor = .black
            cell.dateLabel.textColor = .black
            cell.timeLabel.textColor = .black
            cell.standardNameLabel.textColor = .black
        case 10...12:
            cell.contentView.backgroundColor = UIColor(named: "225")
            cell.iconImageView.image = UIImage(named: "sun")
            cell.cityLabel.textColor = .black
            cell.dateLabel.textColor = .black
            cell.timeLabel.textColor = .black
            cell.standardNameLabel.textColor = .black
        case 13...15:
            cell.contentView.backgroundColor = UIColor(named: "300")
            cell.iconImageView.image = UIImage(named: "sun")
            cell.cityLabel.textColor = .black
            cell.dateLabel.textColor = .black
            cell.timeLabel.textColor = .black
            cell.standardNameLabel.textColor = .black
        case 16...18:
            cell.contentView.backgroundColor = UIColor(named: "350")
            cell.iconImageView.image = UIImage(named: "home")
            cell.cityLabel.textColor = .black
            cell.dateLabel.textColor = .black
            cell.timeLabel.textColor = .black
            cell.standardNameLabel.textColor = .black
        case 19...20:
            cell.contentView.backgroundColor = UIColor(named: "400")
            cell.iconImageView.image = UIImage(named: "rising")
            cell.cityLabel.textColor = .white
            cell.dateLabel.textColor = .white
            cell.timeLabel.textColor = .white
            cell.standardNameLabel.textColor = .white
        case 21...22:
            cell.contentView.backgroundColor = UIColor(named: "500")
            cell.iconImageView.image = UIImage(named: "moon")
            cell.cityLabel.textColor = .white
            cell.dateLabel.textColor = .white
            cell.timeLabel.textColor = .white
            cell.standardNameLabel.textColor = .white
        case 23:
            cell.contentView.backgroundColor = UIColor(named: "000")
            cell.iconImageView.image = UIImage(named: "zzz")
            cell.cityLabel.textColor = .white
            cell.dateLabel.textColor = .white
            cell.timeLabel.textColor = .white
            cell.standardNameLabel.textColor = .white
        default:
            cell.contentView.backgroundColor = .white
            cell.iconImageView.image = UIImage(named: "home")
            cell.cityLabel.textColor = .white
            cell.dateLabel.textColor = .white
            cell.timeLabel.textColor = .white
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
            meals.remove(at: indexPath.row)
            saveMeals()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new region.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            
            os_log("Show detail.", log: OSLog.default, type: .debug)
            guard let mealDetailViewController = segue.destination as? MealViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    
    
    //MARK: Actions
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {

            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // Add a new meal.
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // Save the meals.
            saveMeals()
        }
        
        if let sourceViewController = sender.source as? RegionSmallTableViewController, let meal = sourceViewController.meal {

            // Add a new meal.
            let newIndexPath = IndexPath(row: meals.count, section: 0)
            
            meals.append(meal)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
            // Save the meals.
            saveMeals()
        }
        
        if let sourceViewController = sender.source as? RegionTinyTableViewController, let meal = sourceViewController.meal {

            // Add a new meal.
            let newIndexPath = IndexPath(row: meals.count, section: 0)
            
            meals.append(meal)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
            // Save the meals.
            saveMeals()
        }
    }
    

    //MARK: Private Methods
     
    private func loadSampleMeals() {

        guard let meal1 = RegionTimeZone(city: "Sydney", timezone: "Australia/Sydney") else {
            fatalError("Unable to instantiate meal1")
        }
        guard let meal2 = RegionTimeZone(city: "Tokyo", timezone: "Asia/Tokyo") else {
            fatalError("Unable to instantiate meal2")
        }
        guard let meal3 = RegionTimeZone(city: "Calcutta", timezone: "Asia/Calcutta") else {
            fatalError("Unable to instantiate meal2")
        }
        guard let meal4 = RegionTimeZone(city: "Dubai", timezone: "Asia/Dubai") else {
            fatalError("Unable to instantiate meal2")
        }
        guard let meal5 = RegionTimeZone(city: "Johannesburg", timezone: "Africa/Johannesburg") else {
            fatalError("Unable to instantiate meal2")
        }
        guard let meal6 = RegionTimeZone(city: "Paris", timezone: "Europe/Paris") else {
            fatalError("Unable to instantiate meal2")
        }
        guard let meal12 = RegionTimeZone(city: "UTC", timezone: "Africa/Banjul") else {
            fatalError("Unable to instantiate meal2")
        }
        guard let meal13 = RegionTimeZone(city: "Halifax", timezone: "America/Halifax") else {
            fatalError("Unable to instantiate meal2")
        }
        guard let meal7 = RegionTimeZone(city: "New_York", timezone: "America/New_York") else {
            fatalError("Unable to instantiate meal2")
        }
        guard let meal8 = RegionTimeZone(city: "Chicago", timezone: "America/Chicago") else {
            fatalError("Unable to instantiate meal2")
        }
        guard let meal9 = RegionTimeZone(city: "Denver", timezone: "America/Denver") else {
            fatalError("Unable to instantiate meal2")
        }
        guard let meal10 = RegionTimeZone(city: "Los_Angeles", timezone: "America/Los_Angeles") else {
            fatalError("Unable to instantiate meal2")
        }
        guard let meal11 = RegionTimeZone(city: "Honolulu", timezone: "Pacific/Honolulu") else {
            fatalError("Unable to instantiate meal2")
        }
        
        meals += [meal1, meal2, meal3, meal4, meal5, meal6, meal12, meal13, meal7, meal8, meal9, meal10, meal11]
    }
    
    private func saveMeals() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: RegionTimeZone.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadMeals() -> [RegionTimeZone]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: RegionTimeZone.ArchiveURL.path) as? [RegionTimeZone]
    }
    
    
}
