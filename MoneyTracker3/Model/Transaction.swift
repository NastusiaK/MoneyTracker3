//
//  Transaction.swift
//  MoneyTracker3
//
//  Created by Anastasia Kinelska on 9/26/17.
//  Copyright © 2017 Anastasia Kinelska. All rights reserved.
//

import Foundation
import os.log

class Transaction: NSObject, NSCoding {
    
    // MARK: Properties
    var name:        String
    var category:    Category
    var amountSpent: Double
    var date:        String
    
    // Designated initializer
    init? (name: String, category: Category, amountSpent: Double, date: String ) {
        if name.isEmpty || amountSpent < 0 {
            return nil
        } else {
            self.name        = name
            self.category    = category
            self.amountSpent = amountSpent
            self.date        = date
        }
    }
    
    // MARK NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name,        forKey: "name")
        aCoder.encode(self.category,    forKey: "category")
        aCoder.encode(self.amountSpent, forKey: "amountSpent")
        aCoder.encode(self.date,        forKey: "date")
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        // The name is required, if we cannot decode a name, the initializer should fail
        guard let nameDecode  = aDecoder.decodeObject(forKey: "name") as? String
            else {
                os_log("Unable to decode the name for a Transaction object.", log: OSLog.default, type: .debug)
                return nil
        }
        self.name        = nameDecode
        self.category    = aDecoder.decodeObject(forKey:"category") as! Category
        self.amountSpent = aDecoder.decodeDouble(forKey: "amountSpent")
        self.date        = aDecoder.decodeObject(forKey: "date") as! String
    }
    
}
