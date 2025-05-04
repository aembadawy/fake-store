//
//  UsersView.swift
//  FakeStore
//
//  Created by Aya on 27/04/2025.
//

import SwiftUI

struct UsersView: View {
    @State private var viewModel = UsersViewModel()
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else {
                List {
                    ForEach(viewModel.users) { user in
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
            }
        }
        .task {
            await viewModel.fetchUsers()
        }
    }
}

#Preview {
    UsersView()
}
