//
//  ContentLoadingState.swift
//  FakeStore
//
//  Created by Aya on 04/05/2025.
//

import Foundation

enum ContentLoadingState {
    case loading
    case empty
    case error(error: Error)
    case completed
}

extension ContentLoadingState: Equatable {
    static func == (lhs: ContentLoadingState, rhs: ContentLoadingState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading), (.empty, .empty), (.completed, .completed):
            return true
        case let (.error(lhsError), .error(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
