//
//  NewTransactionViewController.swift
//  MoneyTracker3
//
//  Created by Anastasia Kinelska on 9/27/17.
//  Copyright © 2017 Anastasia Kinelska. All rights reserved.
//

import UIKit

class NewTransactionViewController: UIViewController, UITextFieldDelegate {

// MARK: Properties
    let model = DataModel.dataModel
    
    var transaction: Transaction?
    var transactions = [Transaction]()
    var date: String = ""
    var categoriesArray = [String]()
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var transactionName: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView! = UIPickerView()
    @IBOutlet weak var amountSpentTextField: UITextField!
    @IBOutlet weak var showRecentTransactions: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var saveTransactionButton: UIBarButtonItem!
    
    
// MARK: Actions
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryPicker.delegate = self
        categoryTextField.delegate = self
        categoryPicker.dataSource = self
        categoryPicker.isHidden = true
        date = getCurrentDate()
        categoriesArray = model.getCategoriesNamesList()
    }
    
    @IBAction func editCategory(_ sender: UITextField) {
        categoryPicker.isHidden = false
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        saveTransaction()
        _ = navigationController?.popViewController(animated: true)
    }
    
    func checkField(sender: AnyObject) {
        if (transactionName.text?.isEmpty)! || (categoryTextField.text?.isEmpty)! || (amountSpentTextField.text?.isEmpty)! {
            saveButton.isEnabled = false
            saveTransactionButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
            saveTransactionButton.isEnabled = true
        }
    }
    
    @IBAction func saveTansactionButton(_ sender: UIBarButtonItem) {
        saveTransaction()
        _ = navigationController?.popViewController(animated: true)
        // navigationController?.popToRootViewController(animated: true)
    }
    
    
    func saveTransaction() {
        if let newTransaction = Transaction(name: transactionName.text!, category: model.getCategory(byName: categoryTextField.text!)!, amountSpent: Double(amountSpentTextField.text!)!, date: date) {
            model.addTransaction(transaction: newTransaction)
            model.codeTransactions()
        }
    }
    
    func getCurrentDate() -> String {
        let currentDate = Date()
        let calendar    = Calendar.current
        let month       = calendar.component(.month, from: currentDate)
        let day         = calendar.component(.day, from: currentDate)
        let year        = calendar.component(.year, from: currentDate)
        
        date = ("\(month)" + " " + "\(day)" + " " + "\(year)")
        return date
    }
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = ("M dd YYYY ")
        date = formatter.string(from: datePicker.date)
    }
}

//MARK: Datasource/Delegate for ViewController
    extension NewTransactionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return categoriesArray[row]
        }
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return categoriesArray.count
        }
        
        public func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            categoryTextField.text = categoriesArray[row]
            categoryPicker.isHidden = true
        }
        
}
