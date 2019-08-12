//
//  AddExpenseHeaderView.swift
//  ExpenseTrackerApp
//
//  Created by Chirag N Shah on 10/08/19.
//  Copyright © 2019 Chirag N Shah. All rights reserved.
//

import Foundation
import UIKit

class AddExpenseHeaderView: UIView {
    var amountLabel: UILabel = {
       let amountLabel = UILabel.init(frame: .zero)
        
        
        
        return amountLabel
    }()
    
    var expenseLabel: UILabel = {
        let expenseLabel = UILabel.init(frame: .zero)
        
        return expenseLabel
    }()
    
    var expenseAmountTextField: UITextField = {
        let expenseAmountTextField = UITextField.init(frame: .zero)
        
        return expenseAmountTextField
    }()
    
    var expenseNameTextField: UITextField = {
        let expenseNameTextField = UITextField.init(frame: .zero)
        
        return expenseNameTextField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddExpenseHeaderView: ExpenseInputProtocol {
    func getData() -> (amount: Double, expenseDesc: String) {
        return (Double(expenseAmountTextField.text ?? "") ?? 0, expenseNameTextField.text ?? "")
    }
}
