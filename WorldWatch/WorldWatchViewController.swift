//
//  WorldWatchViewController.swift
//  test2
//
//  Created by emery on 6/12/20.
//  Copyright © 2020 emery. All rights reserved.
//

import UIKit
import os.log


class WorldWatchViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            return
        }
        
        let name = nameTextField.text ?? ""
        let locationlabeltext = mealNameLabel.text ?? ""
        
        // Set the location to be passed to WorldWatchTableViewController after the unwind segue.
        location = TZIdLocation(city: name, timezone: locationlabeltext)
        
    }
    
    //MARK: Actions
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
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
        if let meal = location {
            navigationItem.title = location?.city
            nameTextField.text   = location?.city
            mealNameLabel.text   = location?.timezone
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
    
    //MARK: Actions
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        mealNameLabel.text = "Default Text"
    }
 
    //MARK: Private Methods

    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    
    
}


