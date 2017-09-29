//
//  RecentTransactionsControllerTableViewController.swift
//  MoneyTracker3
//
//  Created by Anastasia Kinelska on 9/27/17.
//  Copyright © 2017 Anastasia Kinelska. All rights reserved.
//

import UIKit

class RecentTransactionsTableViewController: UITableViewController {

    //MARK: Properties
    let model = DataModel.dataModel
    var transactions = [Transaction]()
    
    //MARK: Actions
    override func viewDidLoad() {
        super.viewDidLoad()
        model.decodeTransactions()
        transactions = model.getTransactionsList()
    }
    override func viewDidAppear(_ animated: Bool) {
        model.decodeTransactions()
        transactions = model.getTransactionsList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    // MARK: - TableView data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the numb
        return transactions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TableView cells are reused and should be dequed using a cell identifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as? TransactionsCell else {
            fatalError("The dequeued cell is not an instance of CategoryCell.")
        }
        // Fetch the appropriate category for the data source layout
        let newTransaction = transactions[indexPath.row]
        cell.transactionName.text = newTransaction.name
        cell.categoryName.text = newTransaction.category.name
        cell.date.text = newTransaction.date
        cell.amountSpent.text = String(newTransaction.amountSpent)
        return cell
    }

}
