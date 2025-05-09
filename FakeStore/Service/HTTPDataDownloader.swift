//
//  HTTPDataDownloader.swift
//  FakeStore
//
//  Created by Aya on 07/05/2025.
//

import Foundation

protocol HTTPDataDownloaderProtocol {
    func fetchData<T: Codable>(as type: T.Type) async throws -> [T]
    func refreshData<T: Codable>(as type: T.Type) async throws -> [T]
}

class HTTPDataDownloader: HTTPDataDownloaderProtocol {
    
    private let baseURL = "https://fakestoreapi.com"
    private let endpoint: FakeStoreAPIEndPoint
    private let cache: CacheManager?
    private let refreshIntervel: TimeInterval = 60 * 10 // 10 min
    private var lastFetchTime: Date?
    private let userDefultLastFetchTimeKey: String
    private let urlBuilder: URLBuilder
    private let responseValidator: HTTPResponseValidator

    init(endpoint: FakeStoreAPIEndPoint, cache: CacheManager? = nil) {
        self.endpoint = endpoint
        self.cache = cache
        self.userDefultLastFetchTimeKey = endpoint.path
        self.urlBuilder = URLBuilder(baseURL: baseURL, endpoint: endpoint)
        self.responseValidator = HTTPResponseValidator()
        getLastFetchTime()
    }
    
    func fetchData<T: Codable>(as type: T.Type) async throws -> [T] {
        
        if !needsReferesh, let cache {
            return try cache.getData(as: type)
        }
        
        let url = try urlBuilder.buildURL()
        let (data, response) = try await URLSession.shared.data(from: url)
        try responseValidator.validateResponse(response)
        let result = try JSONDecoder().decode([T].self, from: data)
        
        if let cache {
            setLastFetchTime()
            cache.saveData(result)
        }
        
        return result
    }
    
    func refreshData<T: Codable>(as type: T.Type) async throws -> [T] {
        lastFetchTime = nil
        cache?.invalidate()
        return try await fetchData(as: type)
    }
    
    private func getLastFetchTime() {
        lastFetchTime = UserDefaults.standard
            .value(forKey: userDefultLastFetchTimeKey) as? Date
    }
    
    private func setLastFetchTime() {
        UserDefaults.standard.set(Date(), forKey: userDefultLastFetchTimeKey)
    }
    
    private var needsReferesh: Bool {
        guard let lastFetchTime else { return true }
        return Date().timeIntervalSince(lastFetchTime) >= refreshIntervel
    }
}

