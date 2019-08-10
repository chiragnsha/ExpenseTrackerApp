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
    var expenses: Set<Expense>
    var availableUsers: Set<User> /// check if NSOrderedSet is feasible later.. to extra ordererdUser
    
    var ordererdUsers: [User] {
        return Array(availableUsers.sorted(by: { (lhs, rhs) -> Bool in
            return lhs.name < rhs.name
        }))
    }
}


extension ExpenseManager {
    
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
