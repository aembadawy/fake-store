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
    var contentLoadingState: ContentLoadingState<User> = .loading

    init(service: UsersServiceProtocol = UsersService()) {
        self.service = service
    }

    func fetchUsers() async {
        do {
            let users = try await self.service.fetchUsers()
            contentLoadingState = users.isEmpty ? .empty : .completed(data: users)
        } catch {
            contentLoadingState = .error(error: error)
        }
    }
}
