//
//  ProductsListViewSnapshotTests.swift
//  DemoProductAppSnapshotTests
//
//  Created by Ashish Pal on 16/06/25.
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import DemoProductApp

import Combine
import XCTest

/// A snapshot test suite for the `ProductsListView` to ensure the correct UI appearance under various conditions.
final class ProductsListViewSnapshotTests: XCTestCase {
    
    // MARK: - Snapshot Test for Products List View
    
    /// Tests the snapshot of the `ProductsListView` when it has successfully loaded products.
    ///
    /// This test ensures that the `ProductsListView` correctly displays a list of products and matches
    /// the expected UI appearance. The view is tested with mock data for products.
    func test_ProductsListView_snapshot() {
        // Arrange: Create mock products to simulate a data source for the view
        let mockProducts = [
            Product.mock(id: 1, title: "iPhone 15", price: 999.99),
            Product.mock(id: 2, title: "MacBook Pro", price: 1999.99)
        ]
        
        // Create a mock use case that returns the mock products
        let mockUseCase = MockFetchProductsUseCase(products: mockProducts)
        
        // Initialize the view model with the mock use case
        let viewModel = ProductsListViewModel(fetchProductsUseCase: mockUseCase)
        viewModel.products = mockProducts
        
        // Create the view with the view model
        let view = NavigationView {
            ProductsListView(viewModel: viewModel)
        }
        
        // Act: Assert that the view matches the expected snapshot
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }

    // MARK: - Snapshot Test for Products List View with Error
    
    /// Tests the snapshot of the `ProductsListView` when an error occurs during product loading.
    ///
    /// This test ensures that the view correctly displays an error state and matches the expected UI appearance
    /// when a failure occurs while fetching products.
    func test_ProductsListView_withError() {
        // Arrange: Create a view model with a failing use case that simulates an error
        let viewModel = ProductsListViewModel(fetchProductsUseCase: MockFailingFetchProductsUseCase())
        
        // Create the view with the view model
        let view = ProductsListView(viewModel: viewModel)
        
        // Act: Trigger the load of products (which will fail)
        viewModel.loadProducts()
        
        // Assert: Capture and assert the snapshot to ensure the error state is displayed properly
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }
}
