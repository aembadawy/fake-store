//
//  UsersViewModel.swift
//  FakeStore
//
//  Created by Aya on 28/04/2025.
//

import Foundation

@Observable
class UsersViewModel {
    
    var users = [User]()
    
    init() {
        self.users = User.mockUsers
    }
}
