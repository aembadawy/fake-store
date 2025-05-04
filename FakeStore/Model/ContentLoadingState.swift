//
//  ContentLoadingState.swift
//  FakeStore
//
//  Created by Aya on 04/05/2025.
//

import Foundation

enum ContentLoadingState<T: Codable> {
    case loading
    case empty
    case error(error: Error)
    case completed(data: [T])
}
