//
//  ExpenseDetailViewController.swift
//  ExpenseTrackerApp
//
//  Created by Chirag N Shah on 10/08/19.
//  Copyright © 2019 Chirag N Shah. All rights reserved.
//

import Foundation
import UIKit

class ExpenseDetailViewController: UIViewController {
    ///
    private var expenseManager: ExpenseManager!
    
    internal var tableView: UITableView = UITableView.init(frame: .zero)
    
    init(expenseManager: ExpenseManager) {
    
        self.expenseManager = expenseManager
        
        super.init(nibName: nil, bundle: nil)
        
        self.expenseManager.ordererdUsers.forEach { (user) in
            if let userNetExpense = try? self.expenseManager.netExpense(for: user) {
                print(userNetExpense)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
