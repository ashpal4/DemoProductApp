//
//  FetchProductsUseCaseImpl.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 18/06/25.
//

import Combine

/// Default implementation of `FetchProductsUseCaseProtocol`.
///
/// It relies on a `ProductRepository` to obtain product data.
final class FetchProductsUseCaseImpl: FetchProductsUseCaseProtocol {

    /// The repository responsible for fetching product data.
    private let repository: ProductRepositoryProtocol

    /// Initializes the use case with a product repository.
    ///
    /// - Parameter repository: The product repository to use.
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }

    /// Executes the product fetching process.
    ///
    /// - Returns: A publisher emitting a list of products or an error.
    func execute() -> AnyPublisher<[Product], Error> {
        return repository.fetchProducts()
    }
}

