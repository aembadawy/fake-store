//
//  UsersService.swift
//  FakeStore
//
//  Created by Aya on 02/05/2025.
//

import Foundation

protocol UsersServiceProtocol {
    func fetchUsers() async throws -> [User]
    func refreshUsers() async throws -> [User]
}

class UsersService: UsersServiceProtocol {
    
    private var downloader: HTTPDataDownloaderProtocol
    
    init(
        downloader: HTTPDataDownloaderProtocol = HTTPDataDownloader(
            endpoint: .users,
            cache: CacheManager(filename: "user.json")
        )
    ) {
        self.downloader = downloader
    }
    
    func fetchUsers() async throws -> [User] {
        return try await downloader.fetchData(as: User.self)
    }
    
    func refreshUsers() async throws -> [User] {
        return try await downloader.refreshData(as: User.self)
    }
}
