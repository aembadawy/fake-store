//
//  ProductsView.swift
//  FakeStore
//
//  Created by Aya on 27/04/2025.
//

import SwiftUI

struct ProductsView: View {
    
    @State private var viewModel = ProductsViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.contentLoadingState {
                case . loading:
                    ProgressView()
                case .empty:
                    ContentUnavailableView(
                        "No Products",
                        systemImage: "cart.badge.questionmark"
                    )
                case .error(let error):
                    Text(error.localizedDescription)
                case .completed:
                    List {
                        ForEach(filteredProducts) { product in
                            HStack(spacing: 16) {
                                AsyncImage(url: URL(string: product.image))
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(10)
                                    .clipShape(.rect(cornerRadius: 10))

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(product.title)
                                    Text(product.description)
                                        .lineLimit(2)
                                        .foregroundStyle(.gray)
                                }
                                .font(.subheadline)
                            }
                        }
                    }
                    .searchable(text: $searchText, prompt: "Search here")
                }
            }
            .navigationTitle("Products")
            .refreshable { await viewModel.refreshProducts() }
            .task { await viewModel.fetchProducts() }
        }
        
    }
}

extension ProductsView {
    
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return viewModel.products
        } else {
            return viewModel.products.filter { product in
                product.title.localizedCaseInsensitiveContains(searchText) ||
                product.description.localizedCaseInsensitiveContains(searchText)

            }
        }
    }
}

#Preview {
    ProductsView()
}
