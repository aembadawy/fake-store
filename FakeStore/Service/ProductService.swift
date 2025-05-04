//
//  ProductService.swift
//  FakeStore
//
//  Created by Aya on 01/05/2025.
//

import Foundation

protocol ProductServiceProtocol {
    func fetchProducts() async throws -> [Product]
}

class ProductService: ProductServiceProtocol {
    let urlString = "https://fakestoreapi.com/products"
    
    func fetchProducts() async throws -> [Product] {
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        //validate response 
        return try JSONDecoder().decode([Product].self, from: data)
    }
}
