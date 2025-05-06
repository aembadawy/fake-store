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
    private let refreshIntervel: TimeInterval = 60 * 10 // 10 min
    private var lastFetchTime: Date?
    
    init () { //we can also add the refresh as an input to the service so it's not hard coded
        getLastFetchTime()
    }
    
    private var needsReferesh: Bool {
        guard let lastFetchTime else { return true }
        return Date().timeIntervalSince(lastFetchTime) >= refreshIntervel
    }
    
    func fetchProducts() async throws -> [Product] {
        //cache fetch
        if !needsReferesh, let cachedProducts = try cache.getProducts() {
            return cachedProducts
        }
        
        //Api fetch
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        try validateResponse(response)
        let products = try JSONDecoder().decode([Product].self, from: data)
        setLastFetchTime()
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
    
    private func getLastFetchTime() {
        self.lastFetchTime = UserDefaults.standard.value(forKey: "lastFetchTime") as? Date
    }
    
    private func setLastFetchTime() {
        UserDefaults.standard.set(Date(), forKey: "lastFetchTime")
    }
}
