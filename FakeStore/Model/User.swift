//
//  User.swift
//  FakeStore
//
//  Created by Aya on 27/04/2025.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let username: String
    let email: String
}

extension User {
    
    var mockUsers: [User] {
        
        return [
            User(
                id: 1,
                username: "johndoe",
                email: "johndoe@example.com"
            ),
            User(
                id: 2,
                username: "janedoe",
                email: "janedoe@example.com"
            ),
            User(
                id: 3,
                username: "mike92",
                email: "mike92@example.com"
            ),
            User(
                id: 4,
                username: "sarah_smith",
                email: "sarah_smith@example.com"
            ),
            User(
                id: 5,
                username: "alex_dev",
                email: "alex_dev@example.com"
            )
        ]
    }
}
