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
    case invalidExpenseQuery
}

/// hold all expenses
struct ExpenseManager {
    var expenses: Set<Expense> = Set<Expense>()
    
    func netExpense(for user: User) throws -> Double {
        return try expenses.reduce(into: 0.0, { (result, expense) in
            if(expense.involvesuser(user) == true) {
                result += try self.expenseShare(for: user, in: expense)
            }
        })
    }
    
    func expenseShare(for user: User, in expense: Expense) throws -> Double {
    
        guard expense.involvesuser(user) == true else {
            throw ExpenseManagerError.invalidUser
        }
        
        let expenseShare = expense.expenseAmount / Double.init(expense.involvedUsers.count)
        
        /// user is payee and sharer
        if(expense.payee == user && expense.involvedUsers.contains(user)) {
            return expenseShare - expense.expenseAmount
        } else if (expense.payee == user) { /// user is payee
            return -(expense.expenseAmount)
        } else if(expense.involvedUsers.contains(user)) {/// user is sharer
            return expenseShare
        } else {
            throw ExpenseManagerError.invalidExpenseQuery
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
        
        guard involvedUsers.count > 0 else {
            throw SimpleError(errorTitle: "Invalid number of expense sharers", errorMessage: "Check the number of sharers of the expense")
        }

        let expense = Expense(expenseName: desc, expenseAmount: amount, payee: payee, involvedUsers: involvedUsers)
        self.expenses.insert(expense)
    }
}
