//
//  UsersView.swift
//  FakeStore
//
//  Created by Aya on 27/04/2025.
//

import SwiftUI

struct UsersView: View {
    let users = User.mockUsers
    
    var body: some View {
        List {
            ForEach(users) { user in
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

#Preview {
    UsersView()
}
