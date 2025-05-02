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
    
    init(service: UsersService = UsersService()) {
        self.service = service
    }
    
    func fetchUsers() async {
        do {
            self.users = try await self.service.fetchUsers()
        } catch {
            //handel error
        }
    }
}
