//
//  ProductsViewModel.swift
//  FakeStore
//
//  Created by Aya on 28/04/2025.
//

import Foundation

@Observable
class ProductsViewModel {
    
    var products = [Product]()
    private let service: ProductServiceProtocol
    var isLoading = false
    
    init(service: ProductServiceProtocol = ProductService()) {
        self.service = service
    }
    
    func fetchProducts() async {
        isLoading = true
        defer { isLoading = false }
        do {
            self.products = try await self.service.fetchProducts()
        } catch {
            // handle error
        }
    }
}
