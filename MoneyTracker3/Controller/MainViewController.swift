//
//  MainViewController.swift
//  MoneyTracker3
//
//  Created by Anastasia Kinelska on 9/26/17.
//  Copyright © 2017 Anastasia Kinelska. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
//MARK: Properties
    let model = DataModel.dataModel
    var categories = [Category]()
    var incomes = [Income]()
    
    @IBOutlet weak var currentBalance: UILabel!
    @IBOutlet weak var categoriesTableView: UITableView!
    @IBOutlet weak var newCategoryTextField: UITextField!
    
//MARK: methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.decodeCategories()
        model.decodeTransactions()
        categories = model.getCategoryList()
        if model.getCategoryList().isEmpty {
            categories = createSampleArray()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        categoriesTableView.reloadData()
        model.decodeIncome()
        
        // Current balance + change of color
        currentBalance.text = model.showBalance()
        if (model.countBalance() <= 0.0) {
            currentBalance.textColor = UIColor.red
        } else {
            currentBalance.textColor = UIColor.blue
        }
    }
    
    @IBAction func addNewCategory(_ sender: UIButton) {
        insertNewCategory()
    }
    
    func insertNewCategory(){
        let newCategory = Category(name: newCategoryTextField.text!, amountSpent: 0.0)!
        categories.append(newCategory)
        let indexPath = IndexPath(row: categories.count - 1, section: 0)
        categoriesTableView.beginUpdates()
        categoriesTableView.insertRows(at: [indexPath], with: .automatic)
        categoriesTableView.endUpdates()
        
        newCategoryTextField.text = ""
        view.endEditing(true)
        model.addCategory(category: newCategory)
        model.codeCategories()
    }
    

    private func createSampleArray() -> [Category]{
        
        guard let category01 = Category(name: "Food", amountSpent: 0.0 ) else {
            fatalError ("Unable to instantiate category!")}
        guard let category02 = Category(name: "Utilities", amountSpent: 0.0 ) else {
            fatalError ("Unable to instantiate category!")}
        guard let category03 = Category(name: "Transportation", amountSpent: 0.0 )else {
            fatalError ("Unable to instantiate category!")}
        
        guard let category04 = Category(name: "Internet/Phone", amountSpent: 0.0 )else {
            fatalError ("Unable to instantiate category!")}
        
        guard let category05 = Category(name: "Home", amountSpent: 0.0 )else {
            fatalError ("Unable to instantiate category!")}
        
        guard let category06 = Category(name: "Self care", amountSpent: 0.0 )else {
            fatalError ("Unable to instantiate category!")}
        
        guard let category07 = Category(name: "Vacation", amountSpent: 0.0 )else {
            fatalError ("Unable to instantiate category!")}
        
        model.addCategory(category: category01)
        model.addCategory(category: category02)
        model.addCategory(category: category03)
        model.addCategory(category: category04)
        model.addCategory(category: category05)
        model.addCategory(category: category06)
        model.addCategory(category: category07)
        
        model.codeCategories()
        return model.getCategoryList()
    }
}

// MARK: Datasource/Delegate for UITableView
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TableView cells are reused and should be dequed using a cell identifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CategoryCell else {
            fatalError("The dequeued cell is not an instance of CategoryCell.")
        }
        // Fetch the appropriate category for the data source layout
        let category = categories[indexPath.row]
        cell.categoryNameLabel.text = category.name
        cell.categoryAmountSpentLabel.text = String(model.spentByCategory(category: category))
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            model.removeCategory(category: categories[indexPath.row])
            categories.remove(at: indexPath.row)
            categoriesTableView.beginUpdates()
            categoriesTableView.deleteRows(at: [indexPath], with: .automatic)
            categoriesTableView.endUpdates()
        }
    }
    
}

