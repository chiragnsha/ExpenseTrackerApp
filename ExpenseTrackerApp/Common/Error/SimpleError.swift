//
//  SimpleError.swift
//  ExpenseTrackerApp
//
//  Created by Chirag N Shah on 11/08/19.
//  Copyright © 2019 Chirag N Shah. All rights reserved.
//

import Foundation

protocol ISimpleError: Error {
    var errorTitle: String { get }
    var errorMessage: String { get }
    
}

struct SimpleError: ISimpleError {
    var errorTitle: String
    var errorMessage: String
    
    var localizedDescription: String {
        return errorTitle + errorMessage
    }
}
