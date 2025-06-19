//
//  MockProductRepository.swift
//  DemoProductAppSnapshotTests
//
//  Created by Ashish Pal on 19/06/25.
//

import Combine
@testable import DemoProductApp

// MARK: - Mock Implementations for Testing

/// A mock implementation of `ProductRepositoryProtocol` used for testing purposes.
final class MockProductRepository: ProductRepositoryProtocol {
    
    // MARK: - Properties
    
    /// A list of mock products that can be returned by the repository.
    var productsToReturn: [Product] = []
    
    /// An error that the mock repository may throw when fetching products.
    var errorToThrow: Error?

    // MARK: - Methods
    
    /// Fetches products from the repository, either returning a successful list or throwing an error.
    /// - Returns: A publisher that emits the products or an error.
    func fetchProducts() -> AnyPublisher<[Product], Error> {
        // Return the error if specified, otherwise return the mock products
        if let error = errorToThrow {
            return Fail(error: error).eraseToAnyPublisher()
        } else {
            return Just(productsToReturn)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}

// MARK: - Product Mock Extension

/// Extension to provide a mock implementation of `Product` for testing purposes.
extension Product {
    
    /// Creates a mock `Product` with default or custom values.
    /// - Parameters:
    ///   - id: The ID of the product.
    ///   - title: The title of the product.
    ///   - description: The description of the product.
    ///   - price: The price of the product.
    ///   - rating: The rating of the product.
    ///   - thumbnail: The URL of the product's thumbnail image.
    /// - Returns: A `Product` instance with the provided or default values.
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
