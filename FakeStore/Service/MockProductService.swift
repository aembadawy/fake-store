//
//  MockProductService.swift
//  FakeStore
//
//  Created by Aya on 11/05/2025.
//

import Foundation

class MockProductService: ProductServiceProtocol {
    var mockProducts = Product.mockProducts
    var error: Error?
    
    func fetchProducts() async throws -> [Product] {
        if let error { throw error }
        return mockProducts
    }

    func refreshProducts() async throws -> [Product] {
        if let error { throw error }
        return mockProducts
    }

    
}
