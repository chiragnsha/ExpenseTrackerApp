//
//  UserExpenseCell.swift
//  ExpenseTrackerApp
//
//  Created by Chirag N Shah on 10/08/19.
//  Copyright © 2019 Chirag N Shah. All rights reserved.
//

import UIKit

class UserExpenseCell: UITableViewCell {

    private var userLabel: UILabel
    private var payeeButton: UIButton
    private var sharerButton: UIButton
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        userLabel = UILabel.init(frame: .zero)
        payeeButton = UIButton.init(frame: .zero)
        sharerButton = UIButton.init(frame: .zero)
        
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        setupViews()
    }
    
    func setupViews() {
        setupUserLabel()
        setupPayeeButton()
        setupSharerButton()
        
        payeeButton.addTarget(self, action: #selector(payeeButtonAction(_:)), for: .touchUpInside)
        
        sharerButton.addTarget(self, action: #selector(sharerButtonAction(_:)), for: .touchUpInside)
    }
    
    func configure(for user: User) {
        self.userLabel.text = user.name
    }
    
    @objc private func payeeButtonAction(_ sender: UIButton) {
        print("payeeButtonAction")
        sender.isSelected = !(sender.isSelected)
    }
    
    @objc private func sharerButtonAction(_ sender: UIButton) {
        print("payeeButtonAction")
        sender.isSelected = !(sender.isSelected)
    }
    
    
    private func setupPayeeButton() {
        payeeButton.setTitleColor(UIColor.lightGray, for: .normal)
        payeeButton.setTitleColor(UIColor.black, for: .selected)
        
        
        payeeButton.setTitle("Payee", for: .normal)
        payeeButton.setTitle("Payee", for: .selected)
        
        payeeButton.setImage(UIImage.from(color: UIColor.white), for: .normal)
        payeeButton.setImage(UIImage.from(color: UIColor.red), for: .selected)
        
        payeeButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(payeeButton)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint.init(item: payeeButton, attribute: .left, relatedBy: .equal, toItem: self.userLabel, attribute: .right, multiplier: 1.0, constant: 10.0),
            NSLayoutConstraint.init(item: payeeButton, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
            ])
    }
    
    private func setupSharerButton() {
        sharerButton.setTitleColor(UIColor.lightGray, for: .normal)
        sharerButton.setTitleColor(UIColor.black, for: .selected)
        
        sharerButton.setTitle("Share", for: .normal)
        sharerButton.setTitle("Share", for: .selected)
        
        sharerButton.setImage(UIImage.from(color: UIColor.white), for: .normal)
        sharerButton.setImage(UIImage.from(color: UIColor.red), for: .selected)
        
        
        sharerButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(sharerButton)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint.init(item: sharerButton, attribute: .left, relatedBy: .equal, toItem: self.payeeButton, attribute: .right, multiplier: 1.0, constant: 10.0),
            NSLayoutConstraint.init(item: sharerButton, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint.init(item: sharerButton, attribute: .right, relatedBy: .equal, toItem: self.contentView, attribute: .right, multiplier: 1.0, constant: -10.0)
            ])
    }
    
    private func setupUserLabel() {
        userLabel.text = "User"
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(userLabel)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint.init(item: userLabel, attribute: .left, relatedBy: .equal, toItem: self.contentView, attribute: .left, multiplier: 1.0, constant: 10.0),
            NSLayoutConstraint.init(item: userLabel, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func isPayeeSelected() -> Bool {
        //TODO: This won't work in case of re-use. I added 50 users and buttons get selected randomly as a cell is dequeued. We need to track this state outside.
        return payeeButton.isSelected
    }
    public func isSharerSelected() -> Bool {
        return sharerButton.isSelected
    }
}
