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
    
    private let cache = CacheManager(filename: "products.json")
    private let refreshIntervel: TimeInterval = 60 * 10 // 10 min
    private var lastFetchTime: Date?
    private var downloader: HTTPDataDownloaderProtocol
    
    init (downloader: HTTPDataDownloaderProtocol = HTTPDataDownloader()) { //we can also add the refresh as an input to the service so it's not hard coded
        self.downloader = downloader
        getLastFetchTime()
    }
    
    private var needsReferesh: Bool {
        guard let lastFetchTime else { return true }
        return Date().timeIntervalSince(lastFetchTime) >= refreshIntervel
    }
    
    func fetchProducts() async throws -> [Product] {
        //cache fetch
        if !needsReferesh {
            return try cache.getData(as: Product.self)
        }
        let products = try await downloader.fetchData(as: Product.self, from: .products)
        setLastFetchTime()
        cache.saveData(products)
        return products
    }
    
    private func getLastFetchTime() {
        self.lastFetchTime = UserDefaults.standard.value(forKey: "lastFetchTime") as? Date
    }
    
    private func setLastFetchTime() {
        UserDefaults.standard.set(Date(), forKey: "lastFetchTime")
    }
}
