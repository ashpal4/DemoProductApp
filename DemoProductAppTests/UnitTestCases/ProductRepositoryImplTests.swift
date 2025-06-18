//
//  ProductRepositoryImplTests.swift
//  DemoProductAppTests
//
//  Created by Ashish Pal on 16/06/25.
//

import XCTest
import Combine
@testable import DemoProductApp

final class ProductRepositoryImplTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []

    func test_fetchProducts_success() {
        // Arrange
        let mockDTO = ProductResponseDTO(products: [
            ProductDTO(
                id: 1,
                title: "Test Product",
                price: 99.99,
                thumbnail: "https://example.com/image.jpg",
                description: "Test description"
            )
        ])
        let mockAPIClient = MockAPIClient()
        mockAPIClient.result = .success(mockDTO)

        let repository = ProductRepositoryImpl(apiClient: mockAPIClient)
        let expectation = XCTestExpectation(description: "Fetch products success")

        // Act
        repository.fetchProducts()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success but got failure")
                }
            }, receiveValue: { products in
                XCTAssertEqual(products.count, 1)
                XCTAssertEqual(products.first?.title, "Test Product")
                XCTAssertEqual(products.first?.description, "Test description")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        // Assert
        wait(for: [expectation], timeout: 1)
    }

    func test_fetchProducts_failure() {
        // Arrange
        let mockAPIClient = MockAPIClient()
        mockAPIClient.result = .failure(URLError(.badServerResponse))

        let repository = ProductRepositoryImpl(apiClient: mockAPIClient)
        let expectation = XCTestExpectation(description: "Fetch products failure")

        // Act
        repository.fetchProducts()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure but got success")
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure but got value")
            })
            .store(in: &cancellables)

        // Assert
        wait(for: [expectation], timeout: 1)
    }
}
