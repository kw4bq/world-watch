//
//  Locations.swift
//  WorldWatch
//
//  Created by Emery Clark on 12/12/20.
//  Copyright © 2020 emery. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // Save object in document directory
    func saveObject(fileName: String, object: Any) -> Bool {
        
        let filePath = self.getDirectoryPath().appendingPathComponent(fileName)//1
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)//2
            try data.write(to: filePath)//3
            return true
        } catch {
            print("error is: \(error.localizedDescription)")//4
        }
        return false
    }
    
    // Get object from document directory
    func getObject(fileName: String) -> Any? {
        
        let filePath = self.getDirectoryPath().appendingPathComponent(fileName)//5
        do {
            let data = try Data(contentsOf: filePath)//6
            let object = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)//7
            return object//8
        } catch {
            print("error is: \(error.localizedDescription)")//9
        }
        return nil
    }
    
    //Get the document directory path
    //10
    func getDirectoryPath() -> URL {
        let arrayPaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return arrayPaths[0]
    }
    
//    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
//    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("timezones")
}

//1: File name must be unique for your object otherwise, it will overwrite the older object if saved with same name. Using fileName we are creating a directory file path URL
//2: Create a Data using an object with NSKeyedArchiver class function archivedData.
//3: Save this data at the above URL path.
//4: Check if there is an error while saving the Data.
//5: When you are fetching the object from directory, provide the same file name using which you have saved it. Using the file name create file path URL.
//6: Get the Data from file path URL.
//7: Convert Data into object using NSKeyedUnarchiver class function unarchiveTopLevelObjectWithData.
//8: Return the object.
//9: Catch the error while retrieving our object.
//10: This function returns the document directory path URL.
