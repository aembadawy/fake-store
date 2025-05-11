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
    var products = [Product]()
    var contentLoadingState: ContentLoadingState = .loading
    
    init(service: ProductServiceProtocol = ProductService()) {
        self.service = service
    }
    
    func fetchProducts() async {
        do {
            self.products = try await self.service.fetchProducts()
            contentLoadingState = products.isEmpty ? .empty : .completed
        } catch {
            contentLoadingState = .error(error: error)
        }
    }
    
    func refreshProducts() async {
        do {
            self.products = try await self.service.refreshProducts()
            contentLoadingState = products.isEmpty ? .empty : .completed
        } catch {
            contentLoadingState = .error(error: error)
        }
    }

}
