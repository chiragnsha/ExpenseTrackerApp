//
//  AddExpenseHeaderView+ExpenseInputProtocol.swift
//  ExpenseTrackerApp
//
//  Created by Chirag N Shah on 10/08/19.
//  Copyright © 2019 Chirag N Shah. All rights reserved.
//

import Foundation

extension AddExpenseHeaderView: ExpenseInputProtocol {
    func getExpenseName() -> String? {
        return self.expenseNameTextField.text
    }
    
    func getExpenseAmount() -> String? {
        return self.expenseAmountTextField.text
    }
}
