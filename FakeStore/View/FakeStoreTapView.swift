//
//  ContentView.swift
//  FakeStore
//
//  Created by Aya on 26/04/2025.
//

import SwiftUI

struct FakeStoreTapView: View {
    var body: some View {
        TabView {
            ProductsView()
                .tabItem{
                    Label("Products", systemImage: "cart")
                }
            UsersView()
                .tabItem {
                    Label("Users", systemImage: "person")
                }
        }
    }
}

#Preview {
    FakeStoreTapView()
}
