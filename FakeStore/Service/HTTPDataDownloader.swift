//
//  HTTPDataDownloader.swift
//  FakeStore
//
//  Created by Aya on 07/05/2025.
//

import Foundation

protocol HTTPDataDownloaderProtocol {
    func fetchData<T: Codable>(as type: T.Type, from endpoint: FakeStoreAPIEndPoint) async throws -> [T]
}

struct HTTPDataDownloader: HTTPDataDownloaderProtocol {
    
    let baseURL = "https://fakestoreapi.com"
    
    func fetchData<T: Codable>(as type: T.Type, from endpoint: FakeStoreAPIEndPoint) async throws -> [T] {
        let url = try buildURL(endpoint: endpoint)
        let (data, response) = try await URLSession.shared.data(from: url)
        try validateResponse(response)
        return try JSONDecoder().decode([T].self, from: data)
    }
    
    private func buildURL(endpoint: FakeStoreAPIEndPoint) throws -> URL {
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
