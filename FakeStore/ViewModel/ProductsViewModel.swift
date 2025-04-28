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
    
    init() {
        self.products = Product.mockProducts
    }
}
