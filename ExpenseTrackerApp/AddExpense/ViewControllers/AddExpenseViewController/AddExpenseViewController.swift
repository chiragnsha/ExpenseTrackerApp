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
    
    ///ToAsk: Should have AddExpenseViewModel or UserManager take up the responsibility of tracking Payy/Sharers?
    internal var addExpenseViewModel: AddExpenseViewModel = AddExpenseViewModel()
    
    /// UIView
    private var tableView: UITableView
    internal var expenseInputView: (UIView & ExpenseInputProtocol) = AddExpenseHeaderView(frame: .zero)
    
    init(expenseManager: ExpenseManager, userManager: UserManager) {
        let barAppearance = UINavigationBar.appearance()
        barAppearance.barTintColor = UIColor.blue
        barAppearance.tintColor = UIColor.white
        barAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.expenseManager = expenseManager
        self.userManager = userManager
        self.tableView = UITableView.init(frame: .zero, style: .grouped)
        
        super.init(nibName: nil, bundle: nil)
        
        ///ToAsk: Compiler threw an error: saying
        // Immutable value 'self.addExpenseViewModel' may only be initialized once,
        // Should I have a setdidChangePayee((User?) -> ()) setter in the viewmodel or make addExpenseViewModel into var(since VM are prone to changes)
        self.addExpenseViewModel.didChangePayee = { (user) in
            guard let indexPathsForVisibleRows = self.tableView.indexPathsForVisibleRows else {
                return
            }
            
            self.tableView.reloadRows(at: indexPathsForVisibleRows, with: .none)
        }
        
        self.addExpenseViewModel.didChangeSharer = { (sharer) in
            guard let sharerUserIndex = self.userManager.orderedUsers.firstIndex(of: sharer) else {
                return
            }
            
            self.tableView.reloadRows(at: [IndexPath(row: sharerUserIndex, section: 0)], with: .none)
        }
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
        
        let data = expenseInputView.getData()
        
        /// get payee
        guard let payee = self.addExpenseViewModel.payee else {
            self.showError(error: SimpleError(errorTitle: "Expense Payee is invalid", errorMessage: "Check Payee of the expense"))
            
            return
        }
        
        let sharers = self.addExpenseViewModel.sharers
        
        do {
            try expenseManager.addExpense(data.expenseDesc,
                                               amount: data.amount,
                                               payee: payee,
                                               involvedUsers: Set(sharers))
            let netExpense = try expenseManager.netExpense(for: payee)
            print(netExpense)
        } catch {
            print(error)
        }
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
