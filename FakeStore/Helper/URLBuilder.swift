//
//  URLBuilder.swift
//  FakeStore
//
//  Created by Aya on 09/05/2025.
//

import Foundation

struct URLBuilder {
    let baseURL: String
    let endpoint: FakeStoreAPIEndPoint
    
    init(baseURL: String, endpoint: FakeStoreAPIEndPoint) {
        self.baseURL = baseURL
        self.endpoint = endpoint
    }
    
    func buildURL() throws -> URL {
        guard var components = URLComponents(string: baseURL) else {
            throw APIError.invalidURL
        }
        components.path = endpoint.path
        guard let url = components.url else { throw APIError.invalidURL }
        return url
    }
}
