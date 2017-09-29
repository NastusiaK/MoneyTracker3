//
//  TransactionsCell.swift
//  MoneyTracker3
//
//  Created by Anastasia Kinelska on 9/27/17.
//  Copyright © 2017 Anastasia Kinelska. All rights reserved.
//

import UIKit

class TransactionsCell: UITableViewCell {

    @IBOutlet weak var transactionName: UILabel!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var amountSpent: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    func setTransaction(transaction: Transaction) {
        transactionName.text = transaction.name
        categoryName.text = transaction.category.name
        date.text = transaction.date
        amountSpent.text = String(transaction.amountSpent)   
    }
}
