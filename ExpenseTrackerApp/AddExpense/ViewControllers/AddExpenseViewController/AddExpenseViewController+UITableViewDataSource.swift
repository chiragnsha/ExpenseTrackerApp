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
        
        var tableViewCell: UITableViewCell
        ///ToAsk: What's the most elegant way of doing the following deque based on indexpath
        
        ///non-storyboard cell
        //tableViewCell = tableView.dequeueReusableCell(withIdentifier: UserExpenseCell.cellIdentifier, for: indexPath)
        
        ///storyboard cell
        tableViewCell = tableView.dequeueReusableCell(withIdentifier: UserExpenseViewCell.cellIdentifier, for: indexPath)
        
        ///non-storyboardCell
        if let userExpenseCell = tableViewCell as? UserExpenseCell {
            userExpenseCell.configureView()
            
            /// user indexOf etc... if let here...
            let user = self.userManager.orderedUsers[indexPath.row]
            userExpenseCell.configure(for: user, asPayee: (self.addExpenseViewModel.payee == user), asSharer: self.addExpenseViewModel.sharers.contains(user))
            
            
            userExpenseCell.didTogglePayee = { (userExpenseCell, isPayee) in
                
                ///ToAsk: whats the preffered way to handle loose-ends like these? throw proper errors? or force-unwrap(not ideal) or do nothing and return?
                guard let userCellIndexPath = tableView.indexPath(for: userExpenseCell) else {
                    
                    return
                }
                
                let payeeUser = self.userManager.orderedUsers[userCellIndexPath.row]
                
                if(self.addExpenseViewModel.payee == payeeUser) {
                    self.addExpenseViewModel.removePayee()
                } else {
                    self.addExpenseViewModel.setPayee(payeeUser)
                }
                
                //self.addExpenseViewModel.didChangePayee?(payeeUser)
            }
            
            ///ToAsk: feeling like the the DataSource is bloating with didTogglePayee and didToggleSharer, is it preffered to have another UserCellViewModel for this type of refactoring when required?
            userExpenseCell.didToggleSharer = { (userExpenseCell, isSharer) in
                guard let userCellIndexPath = tableView.indexPath(for: userExpenseCell) else {
                    return
                }
                
                let shareeUser = self.userManager.orderedUsers[userCellIndexPath.row]
                
                if(self.addExpenseViewModel.sharers.contains(shareeUser)) {
                    ///TODO: Handle error cases later
                    try? self.addExpenseViewModel.removeSharer(shareeUser)
                } else {
                    try? self.addExpenseViewModel.addSharer(shareeUser)
                }
                //self.addExpenseViewModel.didChangeSharer?(shareeUser)
            }
        }
        
        ///storyboardCell
        if let userExpenseViewCell = tableViewCell as? UserExpenseViewCell {
            
            userExpenseViewCell.selectionStyle = .none
            
            /// user indexOf etc... if let here...
            let user = self.userManager.orderedUsers[indexPath.row]
            userExpenseViewCell.configure(for: user, asPayee: (self.addExpenseViewModel.payee == user), asSharer: self.addExpenseViewModel.sharers.contains(user))
            
            userExpenseViewCell.didTogglePayee = { (userExpenseCell, isPayee) in
                
                ///ToAsk: whats the preffered way to handle loose-ends like these? throw proper errors? or force-unwrap(not ideal) or do nothing and return?
                guard let userCellIndexPath = tableView.indexPath(for: userExpenseCell) else {
                    
                    return
                }
                
                let payeeUser = self.userManager.orderedUsers[userCellIndexPath.row]
                
                if(self.addExpenseViewModel.payee == payeeUser) {
                    self.addExpenseViewModel.removePayee()
                } else {
                    self.addExpenseViewModel.setPayee(payeeUser)
                }
            }
            
            userExpenseViewCell.didToggleSharer = { (userExpenseCell, isSharer) in
                guard let userCellIndexPath = tableView.indexPath(for: userExpenseCell) else {
                    return
                }
                
                let shareeUser = self.userManager.orderedUsers[userCellIndexPath.row]
                
                if(self.addExpenseViewModel.sharers.contains(shareeUser)) {
                    ///TODO: Handle error cases later
                    try? self.addExpenseViewModel.removeSharer(shareeUser)
                } else {
                    try? self.addExpenseViewModel.addSharer(shareeUser)
                }
                //self.addExpenseViewModel.didChangeSharer?(shareeUser)
            }
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
