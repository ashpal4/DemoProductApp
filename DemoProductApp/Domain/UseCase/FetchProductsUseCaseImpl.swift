//
//  FetchProductsUseCaseImpl.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 18/06/25.
//

import Combine

/// Default implementation of `FetchProductsUseCase`.
///
/// It relies on a `ProductRepository` to obtain product data.
final class FetchProductsUseCaseImpl: FetchProductsUseCase {

    /// The repository responsible for fetching product data.
    private let repository: ProductRepository

    /// Initializes the use case with a product repository.
    ///
    /// - Parameter repository: The product repository to use.
    init(repository: ProductRepository) {
        self.repository = repository
    }

    /// Executes the product fetching process.
    ///
    /// - Returns: A publisher emitting a list of products or an error.
    func execute() -> AnyPublisher<[Product], Error> {
        return repository.fetchProducts()
    }
}

