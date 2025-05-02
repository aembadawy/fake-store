//
//  UsersService.swift
//  FakeStore
//
//  Created by Aya on 02/05/2025.
//

import Foundation

class UsersService {
    
    func fetchUsers() async throws -> [User] {
        return User.mockUsers
    }
}
