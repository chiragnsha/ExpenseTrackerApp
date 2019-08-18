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
    private let expenseManager: ExpenseManager
    private let userManager: UserManager
    
    internal var tableView: UITableView = UITableView(frame: .zero, style: .grouped)
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.cellIdentifier)
        
        self.tableView.dataSource = self
        
        /// trying VFL
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.tableView)
        
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-[tableView]-|", options: NSLayoutConstraint.FormatOptions.alignAllLeft, metrics: nil, views: ["tableView": self.tableView])
        )
        
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[tableView]-0-|", options: NSLayoutConstraint.FormatOptions.alignAllLeft, metrics: nil, views: ["tableView": self.tableView])
        )
    }
}

extension ExpenseDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userManager.orderedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.cellIdentifier, for: indexPath)
        
        let user = self.userManager.orderedUsers[indexPath.row]
        do {
            ///ToAsk: I am going with simple rounded logic, should I explore other options, like NSDecimalFormatter?
            let userNetExpense = try self.expenseManager.netExpense(for: user).rounded()
            
            ///ToAsk: Should I prefer readablility here or just the logic part only?
            tableViewCell.textLabel?.text = user.name + " " + (userNetExpense.sign == .minus ? "gets" : "owes") + " " + String(abs(userNetExpense)) + " " + "Rupees"
        } catch {
            print(error.localizedDescription)
        }
        
        return tableViewCell
    }
}
