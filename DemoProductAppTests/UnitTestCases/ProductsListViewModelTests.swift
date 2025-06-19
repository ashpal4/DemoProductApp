//
//  ProductsListViewModelTests.swift
//  DemoProductAppTests
//
//  Created by Ashish Pal on 16/06/25.
//

import XCTest
import Combine
@testable import DemoProductApp

/// Unit tests for `ProductsListViewModel` covering loading success and error scenarios.
final class ProductsListViewModelTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []

    /// Called after each test method to clear the Combine subscriptions.
    override func tearDown() {
        cancellables = []
        super.tearDown()
    }

    /// Verifies that `loadProducts()` loads products successfully and sets state to `.idle`.
    func test_loadProducts_success() {
        let mockRepo = MockProductRepository()
        let expectedProducts = [Product.mock()]
        mockRepo.productsToReturn = expectedProducts

        let useCase = FetchProductsUseCaseImpl(repository: mockRepo)
        let viewModel = ProductsListViewModel(fetchProductsUseCase: useCase)

        let productsExpectation = expectation(description: "Products loaded")
        let viewStateExpectation = expectation(description: "ViewState returns to idle")

        viewModel.$products
            .dropFirst()
            .sink { products in
                XCTAssertEqual(products, expectedProducts)
                productsExpectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.$viewState
            .dropFirst(2)
            .sink { state in
                XCTAssertEqual(state, .idle)
                viewStateExpectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.loadProducts()
        wait(for: [productsExpectation, viewStateExpectation], timeout: 5.0)
    }

    /// Verifies that `loadProducts()` sets view state to `.error` when fetch fails.
    func test_loadProducts_failure() {
        let mockRepo = MockProductRepository()
        let expectedError = URLError(.badServerResponse)
        mockRepo.errorToThrow = expectedError

        let useCase = FetchProductsUseCaseImpl(repository: mockRepo)
        let viewModel = ProductsListViewModel(fetchProductsUseCase: useCase)

        let errorExpectation = expectation(description: "Error state is emitted")

        viewModel.$viewState
            .dropFirst(2)
            .sink { state in
                if case .error(let message) = state {
                    XCTAssertEqual(message, expectedError.localizedDescription)
                    errorExpectation.fulfill()
                } else {
                    XCTFail("Expected error state, got \(state)")
                }
            }
            .store(in: &cancellables)

        viewModel.loadProducts()
        wait(for: [errorExpectation], timeout: 5.0)
    }
}
