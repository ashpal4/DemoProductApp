//
//  FetchProductsUseCase.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Combine

protocol FetchProductsUseCase {
    func execute() -> AnyPublisher<[Product], Error>
}

final class FetchProductsUseCaseImpl: FetchProductsUseCase {
    private let repository: ProductRepository

    init(repository: ProductRepository) {
        self.repository = repository
    }

    func execute() -> AnyPublisher<[Product], Error> {
        return repository.fetchProducts()
    }
}
