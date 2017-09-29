//
//  IncomeViewController.swift
//  MoneyTracker3
//
//  Created by Anastasia Kinelska on 9/28/17.
//  Copyright © 2017 Anastasia Kinelska. All rights reserved.
//

import UIKit

class IncomeViewController: UIViewController {

    //Mark: Properties
    let model = DataModel.dataModel
    
    var income: Income?
    var incomes = [Income]()
    
    @IBOutlet weak var incomeTextField: UITextField!
    
    // MARK: Actions
    @IBAction func addIncomeButton(_ sender: UIButton) {
        saveIncome()
        _ = navigationController?.popViewController(animated: true)
    }
    
    func saveIncome(){
        if let newIncome = Income(amount: Double(incomeTextField.text!)!) {
        model.addIncomeToStorage(income: newIncome)
        model.codeIncome()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
