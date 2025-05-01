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
    private let service: ProductService
    
    init(service: ProductService = ProductService()) {
        self.service = service
        self.products = Product.mockProducts
    }
    
    func fetchProducts() async {
        do {
            self.products = try await self.service.fetchProducts()
        } catch {
            // handle error
        }
    }
}
