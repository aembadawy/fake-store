//
//  HTTPResponseValidator.swift
//  FakeStore
//
//  Created by Aya on 09/05/2025.
//

import Foundation

struct HTTPResponseValidator {

    func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
    }
}
