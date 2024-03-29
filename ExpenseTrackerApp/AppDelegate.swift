//
//  AppDelegate.swift
//  ExpenseTrackerApp
//
//  Created by Chirag N Shah on 10/08/19.
//  Copyright © 2019 Chirag N Shah. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    /// for holding strong-references for now, move to appDeepdencies later
    //TODO: Should this be force unwrapped. Do we need this variable.
    var expenseManager: ExpenseManager!
    
    lazy var users: Set<User> = {
      var availableUsers = Set<User>.init()
        
        let userA = User.init(ID: UUID.init(), name: "User A")
        let userB = User.init(ID: UUID.init(), name: "User B")
        let userC = User.init(ID: UUID.init(), name: "User C")
        let userD = User.init(ID: UUID.init(), name: "User D")
        
        availableUsers.insert(userA)
        availableUsers.insert(userB)
        availableUsers.insert(userC)
        availableUsers.insert(userB)
        
        return availableUsers
    }()

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /// load with add expense initailly
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        
        /// load app-dependencies
        /// empty expenses for now..
        expenseManager = ExpenseManager(expenses: Set<Expense>.init(), availableUsers: users)
        
        let addExpenseViewController = AddExpenseViewController.init(expenseManager: expenseManager)
        
        let rootViewController = UINavigationController.init(rootViewController: addExpenseViewController)
        
        self.window?.rootViewController = rootViewController
        
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

