//
//  CategoryCell.swift
//  MoneyTracker3
//
//  Created by Anastasia Kinelska on 9/26/17.
//  Copyright © 2017 Anastasia Kinelska. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryAmountSpentLabel: UILabel!
    
    
    func setCategory(category: Category) {
        categoryNameLabel.text = category.name
        categoryAmountSpentLabel.text = String(category.amountSpent)           
    }

}
