//
//  ProductViewModelTest.swift
//  FakeStoreTests
//
//  Created by Aya on 11/05/2025.
//

import Testing
@testable import FakeStore

struct ProductViewModelTest {
    
    @Test func testFetchProductsSuccess() async {
        let service = MockProductService()
        let viewModel = ProductsViewModel(service: service)
        
        await viewModel.fetchProducts()
        
        #expect(viewModel.products == service.mockProducts)
        #expect(viewModel.contentLoadingState == .completed)
    }
    
    @Test func textFetchProductsFailure() async {
        var service = MockProductService()
        let error = APIError.invalidData
        service.error = error
        let viewModel = ProductsViewModel(service: service)
        
        await viewModel.fetchProducts()
        
        #expect(viewModel.contentLoadingState == .error(error: error))
        #expect(viewModel.products.isEmpty)
        
    }
    
    @Test func testProductsEmptyState() async {
        var service = MockProductService()
        service.mockProducts = []
        let viewModel = ProductsViewModel(service: service)
        
        await viewModel.fetchProducts()
        
        #expect(viewModel.products.isEmpty)
    }
    
    @Test func testRefreshProductsSuccess() async {
        let service = MockProductService()
        let viewModel = ProductsViewModel(service: service)
        
        await viewModel.refreshProducts()
        
        #expect(viewModel.products == Product.mockProducts)
        #expect(viewModel.contentLoadingState == .completed)
        
    }
    
    @Test func testRefreshProductsFailure() async {
        var service = MockProductService()
        let error = APIError.invalidResponse
        service.error = error
        let viewModel = ProductsViewModel(service: service)
        
        await viewModel.refreshProducts()
        
        #expect(viewModel.contentLoadingState == .error(error: error))
        #expect(viewModel.products.isEmpty)
    }
}
