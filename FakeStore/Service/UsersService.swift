//
//  UsersService.swift
//  FakeStore
//
//  Created by Aya on 02/05/2025.
//

import Foundation

class UsersService {
    
    let urlString = "https://fakestoreapi.com/users"
    
    func fetchUsers() async throws -> [User] {
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        try validateResponse(response)
        return try JSONDecoder().decode([User].self, from: data)
    }
    
    func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
    }
}
