//
//  UserManager.swift
//  ExpenseTrackerApp
//
//  Created by Sayeed Munawar on 8/12/19.
//  Copyright © 2019 Chirag N Shah. All rights reserved.
//

import Foundation

struct UserManager {
    
    //public private set so that other classes can only read and this class can set
    public private(set) var allUsers: Set<User> = Set<User>() {
        didSet {
            orderedUsers = allUsers.sorted(by: { (user1, user2) -> Bool in
                ///ToAsk: Nice TIL, is there any particular term that defines this util-pattern? Local-Closures
                let op: (User) -> Int = { user in
                    return Int(String(user.name.split(separator: " ").last!))!
                }
                return op(user1) < op(user2)
            })
        }
    }
    
    public private(set) var orderedUsers: Array<User> = Array<User>()
    
    init() {
        loadUsers()
    }

    mutating func loadUsers() {
        var users = Set<User>()
        for i in 1...20 {
            users.insert(User(ID: UUID(), name: "User \(i)"))
        }
        allUsers = users
    }
}
