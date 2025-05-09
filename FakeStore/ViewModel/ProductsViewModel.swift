//
//  ProductsViewModel.swift
//  FakeStore
//
//  Created by Aya on 28/04/2025.
//

import Foundation

@Observable
class ProductsViewModel {
    
    private let service: ProductServiceProtocol
    var contentLoadingState: ContentLoadingState<Product> = .loading
    
    init(service: ProductServiceProtocol = ProductService()) {
        self.service = service
    }
    
    func fetchProducts() async {
        do {
            let products = try await self.service.fetchProducts()
            contentLoadingState = products.isEmpty ? .empty : .completed(data: products)
        } catch {
            contentLoadingState = .error(error: error)
        }
    }
    
    func refreshProducts() async {
        do {
            let products = try await self.service.refreshProducts()
            contentLoadingState = products.isEmpty ? .empty : .completed(data: products)
        } catch {
            contentLoadingState = .error(error: error)
        }
    }

}
