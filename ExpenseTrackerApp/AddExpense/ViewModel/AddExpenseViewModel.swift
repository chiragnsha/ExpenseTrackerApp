//
//  AddExpenseViewModel.swift
//  ExpenseTrackerApp
//
//  Created by Chirag N Shah on 12/08/19.
//  Copyright © 2019 Chirag N Shah. All rights reserved.
//

import Foundation

///ToAsk: What's the most prefered way to organise an iOS-repo, there is no proven standard but I find it hard to structure my repo into proper folders/subfolder/files, less-Clean on that aspect, never settled to a particular structure, I deviate often accross projects.

///ToAsk: AddExpenseViewModel as struct crashes on run while selecting payee, I think this has to do something with Swift-Core fundamentals value-type read/write in a multi=threaded environment, please guide.
internal class AddExpenseViewModel {
    
    public private(set) var payee: User?
    public private(set) var sharers: Set<User>
    
    ///callbacks..
    ///ToAsk: Not familiar how it happens in MVVM world, should I ask the callback/notifyPropertyChanges in the constructors itself? or an optional
    public var didChangePayee: ((User?) -> ())? = nil
    public var didChangeSharer: ((User) -> ())? = nil
    
    ///ToAsk: Should I add callback for sharer-change so that cell reloads and the sharer-button is toggled when cellForRowat is called again, it happens by default for now, is it good to have it just in-case if there is a non-toggleable control? will it not be a over-head to reload other visible-rows also when a single sharer is added? commenting the following it for now
    ///public var didChangeSharers: (() -> ())? = nil
    
    init(_ payee: User? = nil, sharers: Set<User> = Set()) {
        self.payee = payee
        self.sharers = sharers
    }
    
    func setPayee(_ payee: User) {
        self.payee = payee
        
        didChangePayee?(self.payee)
    }
    
    func removePayee() {
        self.payee = nil
        
        didChangePayee?(nil)
    }
    
    func addSharer(_ sharee: User) throws {
        guard self.sharers.insert(sharee).inserted == true else {
            throw AddExpenseViewModelErrors.AddSharerError.sharerExists
        }
        
        didChangeSharer?(sharee)
    }
    
    func removeSharer(_ sharee: User) throws {
        guard let _ = self.sharers.remove(sharee) else {
            throw AddExpenseViewModelErrors.RemoveSharerError.sharerNotAvailable
        }
        
        didChangeSharer?(sharee)
    }
}

///ToAsk: I have not yet explored/concentrated much on Error-modules yet, could seem weak/loose for now. Any tips would defenitely help.
struct AddExpenseViewModelErrors {
    enum AddSharerError: Error {
        case sharerExists
    }
    
    enum RemoveSharerError: Error {
        case sharerNotAvailable
    }
}
