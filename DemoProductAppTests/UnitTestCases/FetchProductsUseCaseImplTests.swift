//
//  FetchProductsUseCaseImplTests.swift
//  DemoProductAppTests
//
//  Created by Ashish Pal on 16/06/25.
//

import XCTest
import Combine
@testable import DemoProductApp

/// Unit tests for `FetchProductsUseCaseImpl`, verifying its success and failure scenarios.
final class FetchProductsUseCaseImplTests: XCTestCase {

    /// A set of Combine cancellables used to manage memory for publishers during testing.
    private var cancellables: Set<AnyCancellable> = []

    /// Called after each test method to clear the Combine subscriptions.
    override func tearDown() {
        cancellables = []
        super.tearDown()
    }

    /// Tests that the `execute()` method returns products successfully when the repository provides data.
    func test_execute_returnsProductsSuccessfully() {
        // Arrange
        let mockRepository = MockProductRepository()
        
        // Expected mock products to be returned
        let expectedProducts = [
            Product.mock(),
            Product.mock(id: 2, title: "Another Product")
        ]
        mockRepository.productsToReturn = expectedProducts

        let useCase = FetchProductsUseCaseImpl(repository: mockRepository)
        let expectation = XCTestExpectation(description: "Should return products")

        // Act & Assert
        useCase.execute()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success, but got failure")
                }
            }, receiveValue: { products in
                // Assert product list count and content
                XCTAssertEqual(products.count, expectedProducts.count)
                XCTAssertEqual(products.first?.title, expectedProducts.first?.title)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    /// Tests that the `execute()` method returns an error when the repository fails to fetch data.
    func test_execute_returnsErrorOnFailure() {
        // Arrange
        let mockRepository = MockProductRepository()
        
        // Simulate error from repository
        mockRepository.errorToThrow = URLError(.badServerResponse)

        let useCase = FetchProductsUseCaseImpl(repository: mockRepository)
        let expectation = XCTestExpectation(description: "Should return error")

        // Act & Assert
        useCase.execute()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertNotNil(error, "Expected an error object")
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure, but got success")
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but received value")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }
}
