//
//  Mocks.swift
//  DemoProductAppSnapshotTests
//
//  Created by Ashish Pal on 16/06/25.
//

import Combine
@testable import DemoProductApp

/// A mock implementation of the `FetchProductsUseCaseProtocol` for testing purposes.
///
/// This mock use case simulates fetching a list of products and can be used in unit tests
/// where you need to mock the behavior of the `FetchProductsUseCase` without making actual network requests.
final class MockFetchProductsUseCase: FetchProductsUseCaseProtocol {
    
    // MARK: - Properties
    
    /// The list of products to be returned by the mock use case.
    private let products: [Product]
    
    // MARK: - Initializer
    
    /// Initializes the mock use case with a list of products.
    ///
    /// - Parameter products: The products that should be returned by the mock use case.
    init(products: [Product]) {
        self.products = products
    }

    // MARK: - Methods
    
    /// Simulates the execution of fetching products and returns the provided list of products as a publisher.
    ///
    /// - Returns: A publisher that emits the list of products and completes successfully.
    ///           The publisher never fails, as it returns the `products` set during initialization.
    func execute() -> AnyPublisher<[Product], Error> {
        // Use Combine's `Just` to emit the mock products as a successful result
        Just(products)
            // Set the failure type to `Error` for type consistency
            .setFailureType(to: Error.self)
            // Erase the type information to return a generic publisher type
            .eraseToAnyPublisher()
    }
}
