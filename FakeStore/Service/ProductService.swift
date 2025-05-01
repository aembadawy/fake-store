//
//  ProductService.swift
//  FakeStore
//
//  Created by Aya on 01/05/2025.
//

import Foundation

class ProductService {
    
    func fetchProducts() async throws -> [Product] {
        return Product.mockProducts
    }
}
