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

    private var downloader: HTTPDataDownloaderProtocol
    
    init (
        downloader: HTTPDataDownloaderProtocol = HTTPDataDownloader(
            endpoint: .products,
            cache: CacheManager(filename: "products.json")
        )
    ) { //we can also add the refresh as an input to the service so it's not hard coded
        self.downloader = downloader
//        getLastFetchTime()
    }
    
    func fetchProducts() async throws -> [Product] {
        return try await downloader.fetchData(as: Product.self)
    }
    
}
