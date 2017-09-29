//
//  Income.swift
//  MoneyTracker3
//
//  Created by Anastasia Kinelska on 9/28/17.
//  Copyright © 2017 Anastasia Kinelska. All rights reserved.
//

import Foundation
import os.log

class Income: NSObject, NSCoding {
    
    var amount:  Double
    
    init? (amount: Double) {
        if amount.isZero {
            return nil
        } else {
            self.amount  = amount
        }
    }
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.amount, forKey: "amount")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.amount  = aDecoder.decodeDouble(forKey: "amount")
    }
    
}
