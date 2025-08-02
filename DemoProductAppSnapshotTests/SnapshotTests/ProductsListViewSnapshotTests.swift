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

/// A snapshot test suite for the `ProductsListView` to ensure the correct UI appearance under various conditions.
final class ProductsListViewSnapshotTests: XCTestCase {
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        // Uncomment the line below to record new snapshots
        // isRecording = true
    }
    
    // MARK: - Snapshot Tests
    /// Tests the snapshot of the `ProductsListView` when it has successfully loaded products.
    func test_ProductsListView_withProducts() {
        // Arrange: Create mock products to simulate a data source for the view
        let mockProducts = [
            Product.mock(id: 1, title: "iPhone 15", price: 999.99),
            Product.mock(id: 2, title: "MacBook Pro", price: 1999.99)
        ]
        
        // Create a mock use case that returns the mock products
        let mockUseCase = MockFetchProductsUseCase(products: mockProducts)
        
        // Initialize the view model with the mock use case
        let viewModel = ProductsListViewModel(fetchProductsUseCase: mockUseCase)
        
        // Create the view with the view model
        let view = NavigationView {
            ProductsListView(viewModel: viewModel)
        }
        
        // Act: Trigger the load of products
        viewModel.loadProducts()
        
        // Assert: Capture and assert the snapshot
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }
    
    /// Tests the snapshot of the `ProductsListView` when there are no products to display.
    func test_ProductsListView_empty() {
        // Arrange: Create a mock use case that returns an empty product list
        let mockUseCase = MockFetchProductsUseCase(products: [])
        
        // Initialize the view model with the mock use case
        let viewModel = ProductsListViewModel(fetchProductsUseCase: mockUseCase)
        
        // Create the view with the view model
        let view = NavigationView {
            ProductsListView(viewModel: viewModel)
        }
        
        // Act: Trigger the load of products
        viewModel.loadProducts()
        
        // Assert: Capture and assert the snapshot
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }
    
    /// Tests the snapshot of the `ProductsListView` when an error occurs during product loading.
    func test_ProductsListView_withError() {
        // Arrange: Create a view model with a failing use case that simulates an error
        let viewModel = ProductsListViewModel(fetchProductsUseCase: MockFailingFetchProductsUseCase())
        
        // Create the view with the view model
        let view = NavigationView {
            ProductsListView(viewModel: viewModel)
        }
        
        // Act: Trigger the load of products (which will fail)
        viewModel.loadProducts()
        
        // Assert: Capture and assert the snapshot
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }
    
    /// Tests the snapshot of the `ProductsListView` during the loading state.
    func test_ProductsListView_loading() {
        // Arrange: Create a mock use case that simulates a loading state
        let mockUseCase = MockLoadingFetchProductsUseCase()
        
        // Initialize the view model with the mock use case
        let viewModel = ProductsListViewModel(fetchProductsUseCase: mockUseCase)
        
        // Create the view with the view model
        let view = NavigationView {
            ProductsListView(viewModel: viewModel)
        }
        
        // Act: Set the view state to loading
        viewModel.viewState = .loading
        
        // Assert: Capture and assert the snapshot
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }
}
