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
    private let userManager: UserManager
    
    internal var tableView: UITableView = UITableView(frame: .zero)
    
    init(expenseManager: ExpenseManager, userManager: UserManager = UserManager()) {
    
        self.expenseManager = expenseManager
        self.userManager = userManager
        
        super.init(nibName: nil, bundle: nil)
        
        self.userManager.allUsers.forEach { (user) in
            if let userNetExpense = try? self.expenseManager.netExpense(for: user) {
                print(userNetExpense)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
