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
            case .completed(let data):
                List {
                    ForEach(data) { user in
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
