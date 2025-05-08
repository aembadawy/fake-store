//
//  HTTPDataDownloader.swift
//  FakeStore
//
//  Created by Aya on 07/05/2025.
//

import Foundation

protocol HTTPDataDownloaderProtocol {
    func fetchData<T: Codable>(as type: T.Type) async throws -> [T]
}

struct HTTPDataDownloader: HTTPDataDownloaderProtocol {
    
    private let baseURL = "https://fakestoreapi.com"
    private let endpoint: FakeStoreAPIEndPoint
    private let cache: CacheManager?
    private let refreshIntervel: TimeInterval = 60 * 10 // 10 min
    private var lastFetchTime: Date?
    private let userDefultLastFetchTimeKey: String
    
    init(endpoint: FakeStoreAPIEndPoint, cache: CacheManager? = nil) {
        self.endpoint = endpoint
        self.cache = cache
        self.userDefultLastFetchTimeKey = endpoint.path
        getLastFetchTime()
    }
    
    func fetchData<T: Codable>(as type: T.Type) async throws -> [T] {
        
        if !needsReferesh, let cache {
            return try cache.getData(as: type)
        }
        
        let url = try buildURL()
        let (data, response) = try await URLSession.shared.data(from: url)
        try validateResponse(response)
        let result = try JSONDecoder().decode([T].self, from: data)
        
        if let cache {
            setLastFetchTime()
            cache.saveData(result)
        }
        
        return result
    }
    
    private func buildURL() throws -> URL {
        guard var components = URLComponents(string: baseURL) else {
            throw APIError.invalidURL
        }
        components.path = endpoint.path
        guard let url = components.url else { throw APIError.invalidURL }
        return url
    }
    
    func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
    }
    
    private mutating func getLastFetchTime() {
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

enum FakeStoreAPIEndPoint {
    case products
    case users
    
    var path: String {
        switch self {
        case .products:
            return "/products"
        case .users:
            return "/users"
        }
    }
}
