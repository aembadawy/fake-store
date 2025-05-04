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
    var service: UsersService
    var isLoading = false
    
    init(service: UsersService = UsersService()) {
        self.service = service
    }
    
    func fetchUsers() async {
        isLoading = true
        defer { isLoading = false }
        do {
            self.users = try await self.service.fetchUsers()
        } catch {
            //handel error
        }
    }
}
