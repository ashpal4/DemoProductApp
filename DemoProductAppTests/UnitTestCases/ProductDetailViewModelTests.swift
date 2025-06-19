//
//  ProductDetailViewModelTests.swift
//  DemoProductAppTests
//
//  Created by Ashish Pal on 16/06/25.
//

import XCTest
@testable import DemoProductApp

/// Unit tests for `ProductDetailViewModel`.
final class ProductDetailViewModelTests: XCTestCase {
    
    /// Verifies that the view model initializes with the correct product.
    func test_init_setsProductCorrectly() {
        let product = Product.mock()
        let viewModel = ProductDetailViewModel(product: product)

        XCTAssertEqual(viewModel.product.title, product.title)
        XCTAssertEqual(viewModel.product.price, product.price)
    }
}
