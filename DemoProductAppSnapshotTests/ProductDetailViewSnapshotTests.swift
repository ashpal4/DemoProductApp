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

final class ProductDetailViewSnapshotTests: XCTestCase {

    func test_ProductDetailView_withValidProduct() {
        let product = Product.mock()
        let viewModel = ProductDetailViewModel(product: product)
        let view = ProductDetailView(viewModel: viewModel)

        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }

    func test_ProductDetailView_withInvalidImageURL() {
        var product = Product.mock()
        product = Product.mock(thumbnail: "invalid-url")
        let viewModel = ProductDetailViewModel(product: product)
        let view = ProductDetailView(viewModel: viewModel)

        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }
}

