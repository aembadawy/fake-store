//
//  APIError.swift
//  FakeStore
//
//  Created by Aya on 04/05/2025.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidData:
            return "Invalid data retrun from API"
        case .invalidURL:
            return "Invalid URL provided"
        case .invalidResponse:
            return "Invalid Response from API"
        }
    }
}
