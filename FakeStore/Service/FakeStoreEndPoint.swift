//
//  FakeStoreEndPoint.swift
//  FakeStore
//
//  Created by Aya on 09/05/2025.
//

import Foundation

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
