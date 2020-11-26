//
//  WorldWatchViewController.swift
//  test2
//
//  Created by emery on 6/12/20.
//  Copyright © 2020 emery. All rights reserved.
//

import UIKit
import os.log


class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    //MARK: Actions
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        cityLabel.text = "Default Text"
    }
    
    
    //MARK: Properties

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var timezoneImageView: UIImageView!
    @IBOutlet weak var nextDSTLabel: UILabel!
    @IBOutlet weak var isDSTLabel: UILabel!
    @IBOutlet weak var localOffsetLabel: UILabel!
    @IBOutlet weak var gmtOffsetLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var standardNameLabel: UILabel!
    @IBOutlet weak var timezoneLabel: UILabel!
    
    /*
     This value is either passed by `WorldWatchTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new location.
     */
    var location: TZIdLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        
        // Set up views if editing an existing location.
        if location != nil {
            navigationItem.title = location?.city
            nameTextField.text   = location?.city
            //cityLabel.text   = location?.timezone
            timeLabel.text = location?.getCurrentTimeWithTimeZone()
            dateLabel.text = location?.getCurrentDateWithTimeZone()
            standardNameLabel.text = location?.getName()
            gmtOffsetLabel.text = "GMT Offset:" + (location?.getGMTOffset())!
            timezoneLabel.text = location?.timezone
            localOffsetLabel.text = "Local Offset:" + (location?.getGMTOffset())!
            isDSTLabel.text = "Is DST? Yes"
            nextDSTLabel.text = "Next DST transisition: Sunday September 14, 2020"
        }
        
        // Enable the Save button only if the text field has a valid location name.
        updateSaveButtonState()
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
 
    //MARK: Private Methods

    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            return
        }
        
        let name = nameTextField.text ?? ""
        let locationlabeltext = cityLabel.text ?? ""
        
        // Set the location to be passed to WorldWatchTableViewController after the unwind segue.
        location = TZIdLocation(city: name, timezone: locationlabeltext)
        
    }
    
}


