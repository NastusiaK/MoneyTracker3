//
//  Category.swift
//  MoneyTracker3
//
//  Created by Anastasia Kinelska on 9/26/17.
//  Copyright © 2017 Anastasia Kinelska. All rights reserved.
//

import Foundation
import os.log

class Category: NSObject, NSCoding {
    
    // MARK: Properties
    var name:        String
    var amountSpent: Double
    var id:          String
    
    init? (name: String, amountSpent: Double) {
        if name.isEmpty || amountSpent < 0 {
            return nil
        } else {
            self.name        = name
            self.amountSpent = amountSpent
            self.id          = NSUUID().uuidString
        }
    }
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name,        forKey: "name")
        aCoder.encode(self.amountSpent, forKey: "amountSpent")
        aCoder.encode(self.id,          forKey: "id")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        // The name is required, if we cannot decode a name, the initializer should fail
        guard let nameDecode  = aDecoder.decodeObject(forKey: "name") as? String
            else {
                os_log("Unable to decode the name for a Category object.", log: OSLog.default, type: .debug)
                return nil
        }
        self.name        = nameDecode
        self.amountSpent = aDecoder.decodeDouble(forKey: "amountSpent")
        self.id          = aDecoder.decodeObject(forKey: "id") as! String
    }
    
}
