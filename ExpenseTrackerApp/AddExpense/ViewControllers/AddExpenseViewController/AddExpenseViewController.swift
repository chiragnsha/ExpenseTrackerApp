//
//  AddExpenseViewController.swift
//  ExpenseTrackerApp
//
//  Created by Chirag N Shah on 10/08/19.
//  Copyright © 2019 Chirag N Shah. All rights reserved.
//

import UIKit

class AddExpenseViewController: UIViewController {

    // Managers
    internal var expenseManager: ExpenseManager
    internal let userManager: UserManager
    
    /// UIView
    private var tableView: UITableView
    internal var expenseInputView: (UIView & ExpenseInputProtocol) = AddExpenseHeaderView.init(frame: .zero)
    
    init(expenseManager: ExpenseManager, userManager: UserManager) {
        let barAppearance = UINavigationBar.appearance()
        barAppearance.barTintColor = UIColor.blue
        barAppearance.tintColor = UIColor.white
        barAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.expenseManager = expenseManager
        self.userManager = userManager
        self.tableView = UITableView.init(frame: .zero, style: .grouped)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTitleView()
        setupTableView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupBottomBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupTitleView()
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.cellIdentifier)
        
        tableView.register(UserExpenseCell.self, forCellReuseIdentifier: UserExpenseCell.cellIdentifier)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint.init(item: self.tableView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint.init(item: self.tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint.init(item: self.tableView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint.init(item: self.tableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0),
            ])
    }
    
    private func setupBottomBar() {
        self.navigationController?.toolbar.barTintColor = UIColor.blue
        
        let leftSpacer = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let submitButton = UIBarButtonItem.init(title: "Submit", style: .done, target: self, action: #selector(addExpense(_:)))
        submitButton.tintColor = UIColor.white
        let rightSpacer = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        self.navigationController?.isToolbarHidden = false
        
        self.navigationController?.toolbar.setItems([leftSpacer, submitButton, rightSpacer], animated: true)
    }
    
    @objc func addExpense(_ sender: UIButton) {
        
        /// validate input later...
        guard let expenseName = expenseInputView.getExpenseName() else {
            //// throw error later...
            self.showError(error: SimpleError(errorTitle: "ExpenseName is invalid", errorMessage: "Check Name of the expense"))
            return
        }
        
        guard let expenseAmount = expenseInputView.getExpenseAmount(),
            let expenseamount = Double.init(expenseAmount) else {
                
            self.showError(error: SimpleError(errorTitle: "ExpenseAmount is invalid", errorMessage: "Check amount of the expense"))
            return
        }
        
        /// get payee

        guard let payee = self.userManager.orderedUsers.enumerated().first(where: { (user) -> Bool in
            guard let userExpenseCell = tableView.cellForRow(at: IndexPath.init(row: user.offset, section: 0)) as? UserExpenseCell else {
                return false
            }
            
            return userExpenseCell.isPayeeSelected()
        })?.element else {
            self.showError(error: SimpleError(errorTitle: "Expense Payee is invalid", errorMessage: "Check Payee of the expense"))
            
            return
        }
        
        
//        ///  mock expense...
//        guard let userA = self.expenseManager.ordererdUsers.first,
//            let userTwo = self.expenseManager.ordererdUsers.last else {
//            return
//        }
        
        let sharers = self.userManager.orderedUsers.enumerated().filter { (user) -> Bool in
            guard let userExpenseCell = tableView.cellForRow(at: IndexPath.init(row: user.offset, section: 0)) as? UserExpenseCell else {
                return false
            }
            
            return userExpenseCell.isSharerSelected()
            }.map { (user) -> User in
              return  user.element
        }
        
        
        let expense = Expense.init(expenseID: UUID.init(), expenseName: expenseName, expenseAmount: expenseamount, payee: payee, involvedUsers: Set.init(sharers))
        
        self.expenseManager.addExpense(expense)
        
        let netExpense = try! self.expenseManager.netExpense(for: payee)
        print(netExpense)
    }
    
    private func setupTitleView() {
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(infoButtonAction(_:)), for: .touchUpInside)
        let infoButtonItem = UIBarButtonItem(customView: infoButton)
        navigationItem.rightBarButtonItem = infoButtonItem
        
        self.title = "Expense"
    }
    
    @objc private func infoButtonAction(_ sender: UIButton) { self.navigationController?.pushViewController(ExpenseDetailViewController.init(expenseManager: self.expenseManager), animated: true)
    }
    
    private func showError(error: ISimpleError) {
        let alertController = UIAlertController.init(title: error.localizedDescription, message: error.localizedDescription, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (alertAction) in
            alertController.dismiss(animated: true, completion: nil)
        }))
    }
}


