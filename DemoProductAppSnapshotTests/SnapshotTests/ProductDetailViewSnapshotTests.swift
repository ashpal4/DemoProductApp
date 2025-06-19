//
//  ProductDetailViewSnapshotTests.swift
//  DemoProductAppSnapshotTests
//
//  Created by Ashish Pal on 16/06/25.
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import DemoProductApp

/// A snapshot test suite for the `ProductDetailView` to ensure the correct UI appearance under various conditions.
final class ProductDetailViewSnapshotTests: XCTestCase {
    
    // MARK: - Snapshot Test for Product Detail View with Valid Product
    
    /// Tests the snapshot of the `ProductDetailView` when a valid product is provided.
    ///
    /// This test ensures that the `ProductDetailView` correctly displays the product details
    /// and matches the expected UI appearance when provided with a valid product with a valid image URL.
    func test_ProductDetailView_withValidProduct() {
        // Arrange: Create a valid mock product
        let product = Product.mock()
        
        // Initialize the view model with the mock product
        let viewModel = ProductDetailViewModel(product: product)
        
        // Create the `ProductDetailView` with the view model
        let view = ProductDetailView(viewModel: viewModel)
        
        // Act: Assert that the view matches the expected snapshot for an iPhone 13 layout
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }

    // MARK: - Snapshot Test for Product Detail View with Invalid Image URL
    
    /// Tests the snapshot of the `ProductDetailView` when an invalid image URL is provided.
    ///
    /// This test ensures that the `ProductDetailView` correctly handles and displays a placeholder
    /// image when an invalid image URL is provided, maintaining the expected UI appearance.
    func test_ProductDetailView_withInvalidImageURL() {
        // Arrange: Create a mock product with an invalid image URL
        var product = Product.mock()
        product = Product.mock(thumbnail: "invalid-url")
        
        // Initialize the view model with the mock product
        let viewModel = ProductDetailViewModel(product: product)
        
        // Create the `ProductDetailView` with the view model
        let view = ProductDetailView(viewModel: viewModel)
        
        // Act: Assert that the view matches the expected snapshot for an iPhone 13 layout
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }
}
