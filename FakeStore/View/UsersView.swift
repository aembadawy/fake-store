//
//  UsersView.swift
//  FakeStore
//
//  Created by Aya on 27/04/2025.
//

import SwiftUI

struct UsersView: View {
    
    @State private var viewModel = UsersViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.contentLoadingState {
                case . loading:
                    ProgressView()
                case .empty:
                    ContentUnavailableView(
                        "No Users",
                        systemImage: "person.slash"
                    )
                case .error(let error):
                    Text(error.localizedDescription)
                case .completed:
                    List {
                        ForEach(filteredUsers) { user in
                            HStack(spacing: 16) {
                                Text("\(user.id)")
                                VStack(alignment: .leading,
                                       spacing: 4) {
                                    Text(user.username)
                                    
                                    Text(user.email)
                                        .foregroundStyle(.gray)
                                }
                            }
                            .font(.subheadline)
                            
                        }
                    }
                    .searchable(text: $searchText, prompt: "Search here")
                }
            }
            .navigationTitle("Users")
            .refreshable { await viewModel.refreshUsers() }
            .task { await viewModel.fetchUsers() }
        }
        
    }
}

extension UsersView {
    
    var filteredUsers: [User] {
        
        if searchText.isEmpty {
            return viewModel.users
        } else {
            return viewModel.users.filter { user in
                user.email.localizedCaseInsensitiveContains(searchText) ||
                user.username.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

#Preview {
    UsersView()
}
