//
//  ProductDetailViewModelTests.swift
//  DemoProductAppTests
//
//  Created by Ashish Pal on 16/06/25.
//

import XCTest
@testable import DemoProductApp

final class ProductDetailViewModelTests: XCTestCase {

    func test_init_setsProductCorrectly() {
        let product = Product.mock()
        let viewModel = ProductDetailViewModel(product: product)

        XCTAssertEqual(viewModel.product.title, product.title)
        XCTAssertEqual(viewModel.product.price, product.price)
    }
}
