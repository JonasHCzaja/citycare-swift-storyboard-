//
//  UIViewController+CoreData.swift
//  CityCare
//
//  Created by Jonas Czaja on 02/09/24.
//

import UIKit
import CoreData

extension UIViewController {
    
    var context: NSManagedObjectContext {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
}
