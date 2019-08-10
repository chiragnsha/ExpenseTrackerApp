//
//  AddExpenseProtocol.swift
//  ExpenseTrackerApp
//
//  Created by Chirag N Shah on 10/08/19.
//  Copyright © 2019 Chirag N Shah. All rights reserved.
//

import Foundation

protocol AddExpenseProtocol {
    mutating func addExpense(_ expense: Expense)
    
}
