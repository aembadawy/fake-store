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
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else {
                List {
                    ForEach(viewModel.products) { product in
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
