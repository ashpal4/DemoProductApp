//
//  DIContainer.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Foundation

final class DIContainer {
    init() {}

    // MARK: - Repositories
    lazy var productRepository: ProductRepository = {
        ProductRepositoryImpl(apiClient: apiClient)
    }()

    // MARK: - Use Cases
    lazy var fetchProductsUseCase: FetchProductsUseCase = {
        FetchProductsUseCaseImpl(repository: productRepository)
    }()

    // MARK: - Services
    private lazy var apiClient: APIClientProtocol = {
        APIClient()
    }()
}
