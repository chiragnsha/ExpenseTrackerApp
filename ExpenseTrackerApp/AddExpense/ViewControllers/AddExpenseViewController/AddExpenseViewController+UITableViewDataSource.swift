//
//  AddExpenseViewController+UITableViewDataSource.swift
//  ExpenseTrackerApp
//
//  Created by Chirag N Shah on 10/08/19.
//  Copyright © 2019 Chirag N Shah. All rights reserved.
//

import Foundation
import UIKit

extension AddExpenseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userManager.orderedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: UserExpenseCell.cellIdentifier, for: indexPath)
        
        ///check for index etc....
        ///tableViewCell.textLabel?.text = self.expenseManager.ordererdUsers[indexPath.row].name
        
        if let userExpenseCell = tableViewCell as? UserExpenseCell {
            userExpenseCell.configureView()
            
            /// user indexOf etc... if let here...
            let user = self.userManager.orderedUsers[indexPath.row]
            userExpenseCell.configure(for: user, asPayee: (self.addExpenseViewModel.payee == user), asSharer: self.addExpenseViewModel.sharers.contains(user))
        }
        
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        ///use AL later...
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return expenseInputView
    }
}
