//
//  UserExpenseViewProtocol.swift
//  ExpenseTrackerApp
//
//  Created by Chirag N Shah on 18/08/19.
//  Copyright © 2019 Chirag N Shah. All rights reserved.
//

import Foundation
import UIKit

protocol UserExpenseInputProtocol {
    ///ToAsk: How do you remove UIKit dependency here, for example later if I want UICollectionViewCell instead of UITableViewCell? One idea I can think of is use generics.
    var didTogglePayee: ((UITableViewCell, Bool) -> ())? { get set }
    var didToggleSharer: ((UITableViewCell, Bool) -> ())? { get set }
    
}

///ToAsk: Figured out that the above scenario is more view dependent, should I refactor like the following?
protocol RefinedUserExpenseInputProtocol {
    var togglePayee: ((UITableViewCell) -> ())? { get set }
    var toggleSharer: ((UITableViewCell) -> ())? { get set }
}
