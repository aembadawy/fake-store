//
//  UsersViewModel.swift
//  FakeStore
//
//  Created by Aya on 28/04/2025.
//

import Foundation

@Observable
class UsersViewModel {
    
    private let service: UsersServiceProtocol
    var users = [User]()
    var contentLoadingState: ContentLoadingState = .loading

    init(service: UsersServiceProtocol = UsersService()) {
        self.service = service
    }

    func fetchUsers() async {
        do {
            self.users = try await self.service.fetchUsers()
            contentLoadingState = users.isEmpty ? .empty : .completed
        } catch {
            contentLoadingState = .error(error: error)
        }
    }
    
    func refreshUsers() async {
        do {
            self.users = try await self.service.refreshUsers()
            contentLoadingState = users.isEmpty ? .empty : .completed
        } catch {
            contentLoadingState = .error(error: error)
        }
    }
}
