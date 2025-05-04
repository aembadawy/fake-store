//
//  Product.swift
//  FakeStore
//
//  Created by Aya on 27/04/2025.
//

import Foundation

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let category: String
    let image: String
    let description: String
    let price: Double
}
