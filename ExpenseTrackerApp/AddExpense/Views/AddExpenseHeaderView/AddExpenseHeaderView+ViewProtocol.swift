//
//  AddExpenseHeaderView+ViewProtocol.swift
//  ExpenseTrackerApp
//
//  Created by Chirag N Shah on 10/08/19.
//  Copyright © 2019 Chirag N Shah. All rights reserved.
//

import Foundation
import UIKit

extension AddExpenseHeaderView: ViewProtocol {
    func configureView() {
        /// set amount, expnse label and textfields
        setupAmountLabel()
        setupAmountTextField()
        setupExpenseLabel()
        setupExpenseTextField()
        
    }
    
    private func setupAmountLabel() {
        amountLabel.text = "Amount"
        
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        amountLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        amountLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        amountLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        amountLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        self.addSubview(amountLabel)
        
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint.init(item: amountLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 16.0),
            NSLayoutConstraint.init(item: amountLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 16.0)
            ])
    }
    
    private func setupAmountTextField() {
        expenseAmountTextField.backgroundColor = UIColor.red
        expenseAmountTextField.translatesAutoresizingMaskIntoConstraints = false
        
        expenseAmountTextField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        expenseAmountTextField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        expenseAmountTextField.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        expenseAmountTextField.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        self.addSubview(expenseAmountTextField)
        
        /// constraitns
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint.init(item: expenseAmountTextField, attribute: .left, relatedBy: .equal, toItem: self.amountLabel, attribute: .right, multiplier: 1.0, constant: 8.0),
            NSLayoutConstraint.init(item: expenseAmountTextField, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 16.0),
            NSLayoutConstraint.init(item: expenseAmountTextField, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: -16.0)
            ])
    }
    
    private func setupExpenseLabel() {
        expenseLabel.text = "Expense"
        expenseLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(expenseLabel)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint.init(item: expenseLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 16.0),
            NSLayoutConstraint.init(item: expenseLabel, attribute: .top, relatedBy: .equal, toItem: self.amountLabel, attribute: .bottom, multiplier: 1.0, constant: 16.0),
            NSLayoutConstraint.init(item: expenseLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -16.0)
            ])
        
    }
    
    private func setupExpenseTextField() {
        expenseNameTextField.backgroundColor = UIColor.yellow
        expenseNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(expenseNameTextField)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint.init(item: expenseNameTextField, attribute: .left, relatedBy: .equal, toItem: self.expenseLabel, attribute: .right, multiplier: 1.0, constant: 8.0),
            NSLayoutConstraint.init(item: expenseNameTextField, attribute: .top, relatedBy: .equal, toItem: self.expenseAmountTextField, attribute: .bottom, multiplier: 1.0, constant: 16.0),
            NSLayoutConstraint.init(item: expenseNameTextField, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: -16.0),
            NSLayoutConstraint.init(item: expenseNameTextField, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -16.0)
            ])
    }
}
