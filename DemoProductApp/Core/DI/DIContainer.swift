//
//  DIContainer.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Foundation

/// A simple dependency injection container for providing application-wide dependencies.
///
/// `DIContainer` centralizes the creation of repositories, use cases, and services.
final class DIContainer {

    /// Initializes a new instance of the container.
    init() {}

    // MARK: - Repositories

    /// Lazily initialized product repository.
    lazy var productRepository: ProductRepository = {
        ProductRepositoryImpl(apiClient: apiClient)
    }()

    // MARK: - Use Cases

    /// Lazily initialized use case for fetching products.
    lazy var fetchProductsUseCase: FetchProductsUseCase = {
        FetchProductsUseCaseImpl(repository: productRepository)
    }()

    // MARK: - Services

    /// Lazily initialized API client used for network communication.
    private lazy var apiClient: APIClientProtocol = {
        APIClient()
    }()
}
