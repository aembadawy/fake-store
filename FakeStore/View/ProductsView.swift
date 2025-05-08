//
//  ProductsView.swift
//  FakeStore
//
//  Created by Aya on 27/04/2025.
//

import SwiftUI

struct ProductsView: View {
    
    @State private var viewModel = ProductsViewModel()
    
    var body: some View {
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
            case .completed(let data):
                List {
                    ForEach(data) { product in
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
            }
        }
        .task {
            await viewModel.fetchProducts()
        }
    }
}

#Preview {
    ProductsView()
}
