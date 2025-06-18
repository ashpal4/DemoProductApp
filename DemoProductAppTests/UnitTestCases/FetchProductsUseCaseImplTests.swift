//
//  FetchProductsUseCaseImplTests.swift
//  DemoProductAppTests
//
//  Created by Ashish Pal on 16/06/25.
//

import XCTest
import Combine
@testable import DemoProductApp

final class FetchProductsUseCaseImplTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    
    override func tearDown() {
        cancellables = []
        super.tearDown()
    }

    func test_execute_returnsProductsSuccessfully() {
        // Arrange
        let mockRepository = MockProductRepository()
        let expectedProducts = [Product.mock(), Product.mock(id: 2, title: "Another Product")]
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
                XCTAssertEqual(products.count, expectedProducts.count)
                XCTAssertEqual(products.first?.title, expectedProducts.first?.title)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func test_execute_returnsErrorOnFailure() {
        // Arrange
        let mockRepository = MockProductRepository()
        mockRepository.errorToThrow = URLError(.badServerResponse)

        let useCase = FetchProductsUseCaseImpl(repository: mockRepository)
        let expectation = XCTestExpectation(description: "Should return error")

        // Act & Assert
        useCase.execute()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertNotNil(error)
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
