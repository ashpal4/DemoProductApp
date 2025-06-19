//
//  MockProductRepository.swift
//  DemoProductAppTests
//
//  Created by Ashish Pal on 16/06/25.
//

import Combine
@testable import DemoProductApp

/// A mock implementation of `ProductRepositoryProtocol` for use in unit tests.
final class MockProductRepository: ProductRepositoryProtocol {
    
    /// The list of products to return when `fetchProducts()` is called.
    var productsToReturn: [Product] = []
    
    /// An optional error to simulate a failure when `fetchProducts()` is called.
    var errorToThrow: Error?

    /// Simulates fetching products, returning either a list or an error using Combine publishers.
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

/// Extension providing a convenient way to create mock `Product` instances for tests.
extension Product {
    
    /// Returns a mock `Product` instance with default or custom values.
    ///
    /// - Parameters:
    ///   - id: Unique product ID. Default is `1`.
    ///   - title: Product title. Default is `"Mock Product"`.
    ///   - description: Product description. Default is `"Mock description"`.
    ///   - price: Product price. Default is `99`.
    ///   - rating: Product rating. (Currently unused in constructor). Default is `4.5`.
    ///   - thumbnail: Product image URL. Default is a test image URL.
    /// - Returns: A `Product` instance populated with test data.
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
