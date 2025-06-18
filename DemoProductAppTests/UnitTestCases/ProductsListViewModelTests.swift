//
//  ProductsListViewModelTests.swift
//  DemoProductAppTests
//
//  Created by Ashish Pal on 16/06/25.
//

import XCTest
import Combine
@testable import DemoProductApp

final class ProductsListViewModelTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    
    override func tearDown() {
        cancellables = []
        super.tearDown()
    }

    func test_loadProducts_success() {
        // Arrange
        let mockRepo = MockProductRepository()
        let expectedProducts = [Product.mock()]
        mockRepo.productsToReturn = expectedProducts

        let useCase = FetchProductsUseCaseImpl(repository: mockRepo)
        let viewModel = ProductsListViewModel(fetchProductsUseCase: useCase)

        let productsExpectation = expectation(description: "Products loaded")
        let viewStateExpectation = expectation(description: "ViewState returns to idle")

        // Observe product loading
        viewModel.$products
            .dropFirst()
            .sink { products in
                XCTAssertEqual(products, expectedProducts)
                productsExpectation.fulfill()
            }
            .store(in: &cancellables)

        // Observe state change to .idle
        viewModel.$viewState
            .dropFirst(2) // initial (.idle), then (.loading), then (.idle)
            .sink { state in
                XCTAssertEqual(state, .idle)
                viewStateExpectation.fulfill()
            }
            .store(in: &cancellables)

        // Act
        viewModel.loadProducts()

        // Assert
        wait(for: [productsExpectation, viewStateExpectation], timeout: 5.0)
    }

    func test_loadProducts_failure() {
        // Arrange
        let mockRepo = MockProductRepository()
        let expectedError = URLError(.badServerResponse)
        mockRepo.errorToThrow = expectedError

        let useCase = FetchProductsUseCaseImpl(repository: mockRepo)
        let viewModel = ProductsListViewModel(fetchProductsUseCase: useCase)

        let errorExpectation = expectation(description: "Error state is emitted")

        // Observe state for error
        viewModel.$viewState
            .dropFirst(2) // initial (.idle), then (.loading), then (.error)
            .sink { state in
                if case .error(let message) = state {
                    XCTAssertEqual(message, expectedError.localizedDescription)
                    errorExpectation.fulfill()
                } else {
                    XCTFail("Expected error state, got \(state)")
                }
            }
            .store(in: &cancellables)

        // Act
        viewModel.loadProducts()

        // Assert
        wait(for: [errorExpectation], timeout: 5.0)
    }
}
