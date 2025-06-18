//
//  Mocks.swift
//  DemoProductAppSnapshotTests
//
//  Created by Ashish Pal on 16/06/25.
//

import Foundation
import Combine
@testable import DemoProductApp

final class MockFetchProductsUseCase: FetchProductsUseCaseProtocol {
    private let products: [Product]
    
    init(products: [Product]) {
        self.products = products
    }

    func execute() -> AnyPublisher<[Product], Error> {
        Just(products)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

final class MockFailingFetchProductsUseCase: FetchProductsUseCaseProtocol {
    func execute() -> AnyPublisher<[Product], Error> {
        Fail(error: URLError(.badServerResponse))
            .eraseToAnyPublisher()
    }
}
