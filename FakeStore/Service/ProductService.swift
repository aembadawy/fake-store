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
    private let urlString = "https://fakestoreapi.com/products"
    private let cache = ProductCache()
    
    func fetchProducts() async throws -> [Product] {
        if let cachedProducts = try cache.getProducts() {
            return cachedProducts
        }
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        try validateResponse(response)
        let products = try JSONDecoder().decode([Product].self, from: data)
        cache.saveProducts(products)
        return products
    }
    
    func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
    }
}
