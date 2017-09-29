//
//  DataModel.swift
//  MoneyTracker3
//
//  Created by Anastasia Kinelska on 9/26/17.
//  Copyright © 2017 Anastasia Kinelska. All rights reserved.
//

import Foundation

class DataModel {
    
    // MARK: Properties
    private var incomeStorage:          [Income]       = []
    private var categoryStorage:        [Category]     = []
    private var transactionsStorage:    [Transaction]  = []
    private let fileManager                            = FileManager()
    
    private let incomePath:       String?
    private let categoriesPath:   String?
    private let transactionsPath: String?
    
    
    static let dataModel = DataModel()
    
    
    private init(){
        
    // Prepare for Archiving data to files
    let documentDirectoryUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
    if let documentDirectoryUrl = documentDirectoryUrls.first {
         self.incomePath        = documentDirectoryUrl.appendingPathComponent("income").path
         self.categoriesPath    = documentDirectoryUrl.appendingPathComponent("categories.archive").path
         self.transactionsPath  = documentDirectoryUrl.appendingPathComponent("transactions.archive").path
        
         } else {
             self.incomePath       = nil
             self.categoriesPath   = nil
             self.transactionsPath = nil
        }
    }
    
    // MARK: Balance methods
    func showBalance() -> String{
        let bal = countBalance()
        return String(bal)
    }
    
    func countBalance() -> Double {
        var newBalance = 0.0
        for i in transactionsStorage {
            newBalance -= i.amountSpent
        }
        for i in incomeStorage {
            newBalance += i.amount
        }
        return newBalance
    }
    
    func addIncomeToStorage(income: Income) {
        incomeStorage.append(income)
    }
    
    // MARK: Income methods
    func countIncome() -> Double {
        var total = 0.0
        for i in incomeStorage {
            total += i.amount
        }
        return total
    }
    
    func getIncomeList() -> [Income] {
        return incomeStorage
    }
    
    // MARK: Categories methods
    func getCategoryList() -> [Category]{
        return categoryStorage
    }
    
    func getCategoriesNamesList() -> [String] {
        var names = [String]()
        for n in getCategoryList(){
            names.append(n.name)
        }
        return names
    }
    
    func addCategory(category: Category) {
        categoryStorage.append(category)
    }
    
    func removeCategory(category: Category) {
        categoryStorage.remove(at: (categoryStorage.index(of: category)!))
        codeCategories()
    }
    
    func getCategory(byName: String) -> Category? {
        for i in categoryStorage {
            if i.name == byName {
                return i
            }
        }
        return nil
    }
    
    func spentByCategory(category: Category) -> Double{
        var spent = 0.0
        for i in transactionsStorage {
            if category.name == i.category.name {
                spent += i.amountSpent
            }
        }
        return spent
    }
    
    // MARK: Transaction methods
    func getTransactionsList() -> [Transaction]{
        return transactionsStorage
    }
    
    func addTransaction(transaction: Transaction) {
        transactionsStorage.append(transaction)
    }

    // MARK: Income code/decode
    func codeIncome(){
        if incomePath != nil {
            let success = NSKeyedArchiver.archiveRootObject(incomeStorage, toFile: incomePath!)
            if !success {
                print("Unable to save array to \(incomePath!)")
            }
        }
    }
    
    func decodeIncome(){
        if incomePath != nil,
            let incomeList = NSKeyedUnarchiver.unarchiveObject(withFile: incomePath!) as? [Income]
        {
            incomeStorage = incomeList
        } else {
            print("File not found")
        }
    }
    
   // MARK: Category code/decode
    func codeCategories(){
        if categoriesPath != nil {
            let success = NSKeyedArchiver.archiveRootObject(categoryStorage, toFile: categoriesPath!)
            if !success {
                print("Unable to save array to \(categoriesPath!)")
            }
            }
        }
    
    func decodeCategories(){
        if categoriesPath != nil,
            let categoryList = NSKeyedUnarchiver.unarchiveObject(withFile: categoriesPath!) as? [Category]
        {
            categoryStorage = categoryList
        } else {
            print("File not found")
        }
    }
    
    // MARK: TRansactions code/decode
    func codeTransactions(){
        if transactionsPath != nil {
            let success = NSKeyedArchiver.archiveRootObject(transactionsStorage, toFile: transactionsPath!)
            if !success {
                print("Unable to save array to \(transactionsPath!)")
            }
        }
    }
    
    func decodeTransactions(){
        if transactionsPath != nil,
            let transactionsList = NSKeyedUnarchiver.unarchiveObject(withFile: transactionsPath!) as? [Transaction]
        {
            transactionsStorage = transactionsList
        } else {
            print("File not found")
        }
    }
    
}
