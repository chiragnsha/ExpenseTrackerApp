//
//  ExpenseManager.swift
//  ExpenseTrackerApp
//
//  Created by Chirag N Shah on 10/08/19.
//  Copyright © 2019 Chirag N Shah. All rights reserved.
//

import Foundation

enum ExpenseManagerError: Error {
    case invalidUser
}

/// hold all expenses
struct ExpenseManager {
    var expenses: Set<Expense> = Set<Expense>()
    
    func netExpense(for user: User) throws -> Double {
        return try expenses.reduce(into: 0.0, { (result, expense) in
            result += try self.expenseShare(for: user, in: expense)
        })
    }
    
    func expenseShare(for user: User, in expense: Expense) throws -> Double {
    
        guard expense.involvesuser(user) == true else {
            throw ExpenseManagerError.invalidUser
        }
        
        let expenseShare = expense.expenseAmount / Double.init(expense.involvedUsers.count)
        
        if(expense.involvedUsers.contains(user) == true) {
            return expenseShare
        } else {
            return 0.0
        }
    }
}

extension ExpenseManager: AddExpenseProtocol {
    
    mutating func addExpense(_ desc: String, amount: Double, payee: User, involvedUsers: Set<User>) throws {
        /// validate expense
        guard !desc.isEmpty else {
            throw SimpleError(errorTitle: "ExpenseName is invalid", errorMessage: "Check Name of the expense")
        }
        
        guard amount > 0 else {
            throw SimpleError(errorTitle: "ExpenseAmount is invalid", errorMessage: "Check amount of the expense")
        }

        let expense = Expense(expenseName: desc, expenseAmount: amount, payee: payee, involvedUsers: involvedUsers)
        self.expenses.insert(expense)
    }
}
