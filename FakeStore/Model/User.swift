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
