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

@MainActor
final class ProductsListViewSnapshotTests: XCTestCase {

    func test_ProductsListView_snapshot() {
        let mockProducts = [
            Product.mock(id: 1, title: "iPhone 15", price: 999.99),
            Product.mock(id: 2, title: "MacBook Pro", price: 1999.99)
        ]

        let mockUseCase = MockFetchProductsUseCase(products: mockProducts)
        let viewModel = ProductsListViewModel(fetchProductsUseCase: mockUseCase)
        viewModel.products = mockProducts

        let view = NavigationView {
            ProductsListView(viewModel: viewModel)
        }

        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }
    
    func test_ProductsListView_withError() {
        let viewModel = ProductsListViewModel(fetchProductsUseCase: MockFailingFetchProductsUseCase())
        let view = ProductsListView(viewModel: viewModel)
        
        viewModel.loadProducts()
        
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }
}

import Combine

final class MockProductRepository: ProductRepositoryProtocol {
    var productsToReturn: [Product] = []
    var errorToThrow: Error?

    func fetchProducts() -> AnyPublisher<[Product], Error> {
        if let error = errorToThrow {
            return Fail(error: error).eraseToAnyPublisher()
        } else {
            return Just(productsToReturn)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}

extension Product {
    static func mock(
        id: Int = 1,
        title: String = "Mock Product",
        description: String = "Mock description",
        price: Double = 99,
        rating: Double = 4.5,
        thumbnail: String = "https://test.com/image.jpg"
    ) -> Product {
        return Product(id: id, title: title, price: price, thumbnail: thumbnail, description: description)
    }
}
