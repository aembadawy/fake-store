//
//  CacheManager.swift
//  FakeStore
//
//  Created by Aya on 08/05/2025.
//

import Foundation

struct CacheManager: CacheManagerProtocol {
    let filename: String
    
    init(filename: String) {
        self.filename = filename
    }
}
