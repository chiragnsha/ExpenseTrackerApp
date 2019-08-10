//
//  ExpenseManager+AddExpenseProtocol.swift
//  ExpenseTrackerApp
//
//  Created by Chirag N Shah on 10/08/19.
//  Copyright © 2019 Chirag N Shah. All rights reserved.
//

import Foundation

extension ExpenseManager: AddExpenseProtocol {
    
    mutating func addExpense(_ expense: Expense) {
        /// validate expense
        /// implement throws
        
        self.expenses.insert(expense)
    }
}
