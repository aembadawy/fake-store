//
//  Product.swift
//  FakeStore
//
//  Created by Aya on 27/04/2025.
//

import Foundation

struct Product: Codable, Identifiable, Equatable {
    let id: Int
    let title: String
    let category: String
    let image: String
    let description: String
    let price: Double
}

extension Product {
    static let mockProducts: [Product] = [
        Product(
            id: 1,
            title: "Wireless Headphones",
            category: "Electronics",
            image: "https://picsum.photos/200/200?random=1",
            description: "High-quality wireless headphones with noise cancellation and 20 hours of battery life.",
            price: 199.99
        ),
        Product(
            id: 2,
            title: "Organic Cotton T-Shirt",
            category: "Clothing",
            image: "https://picsum.photos/200/200?random=2",
            description: "Comfortable and eco-friendly organic cotton t-shirt available in multiple colors.",
            price: 29.99
        ),
        Product(
            id: 3,
            title: "Espresso Coffee Maker",
            category: "Home Appliances",
            image: "https://picsum.photos/200/200?random=3",
            description: "Compact espresso coffee maker with easy-to-use controls and fast brewing time.",
            price: 89.99
        ),
        Product(
            id: 4,
            title: "Yoga Mat",
            category: "Sports",
            image: "https://picsum.photos/200/200?random=4",
            description: "Durable non-slip yoga mat, perfect for all types of workouts and yoga sessions.",
            price: 45.00
        ),
        Product(
            id: 5,
            title: "Smartwatch Series 7",
            category: "Electronics",
            image: "https://picsum.photos/200/200?random=5",
            description: "Feature-packed smartwatch with health tracking, GPS, and customizable watch faces.",
            price: 399.99
        )
    ]
}
