//
//  UserExpenseCellView.swift
//  ExpenseTrackerApp
//
//  Created by Chirag N Shah on 14/08/19.
//  Copyright © 2019 Chirag N Shah. All rights reserved.
//

import Foundation
import UIKit

class UserExpenseViewCell: UITableViewCell, UserExpenseInputProtocol {
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var payeeButton: UIButton!
    @IBOutlet weak var sharerButton: UIButton!
    
    var didTogglePayee: ((UITableViewCell, Bool) -> ())?
    var didToggleSharer: ((UITableViewCell, Bool) -> ())?
    
    @IBAction func payeeButtonTap(_ sender: Any) {
        guard let payeeButton = sender as? UIButton else {
            return
        }
        
        ///ToAsk: The logic is more View-dependent, is this correct?
        didTogglePayee?(self, !(payeeButton.isSelected))
    }
    
    @IBAction func sharerButtonTap(_ sender: Any) {
        guard let sharerButton = sender as? UIButton else {
            return
        }
        
        didToggleSharer?(self, !(sharerButton.isSelected))
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(for user: User, asPayee isPayee: Bool, asSharer isSharer: Bool) {
        
        ///ToAsk: where should the following four setTitle calls reside for storyboard cells? bcz since its common across cells, why set the title again and again in cellforrowat while knowing that is going to be the same across all cells.
        self.payeeButton.setTitle("Payee", for: .normal)
        self.payeeButton.setTitle("Payee", for: .selected)
        
        self.sharerButton.setTitle("Sharer", for: .normal)
        self.sharerButton.setTitle("Sharer", for: .selected)
        
        self.userNameLabel.text = user.name
        
        self.payeeButton.isSelected = isPayee
        self.sharerButton.isSelected = isSharer
    }
}
