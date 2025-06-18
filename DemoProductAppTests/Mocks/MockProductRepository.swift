//
//  MockProductRepository.swift
//  DemoProductAppTests
//
//  Created by Ashish Pal on 16/06/25.
//

import Combine
@testable import DemoProductApp

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
