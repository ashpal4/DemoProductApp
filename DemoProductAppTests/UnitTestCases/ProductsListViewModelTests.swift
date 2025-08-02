//
//  ProductsListViewModelTests.swift
//  DemoProductAppTests
//
//  Created by Ashish Pal on 16/06/25.
//

import XCTest
import Combine
@testable import DemoProductApp

/// Unit tests for `ProductsListViewModel` covering loading success, empty, and error scenarios.
final class ProductsListViewModelTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    
    /// Called after each test method to clear the Combine subscriptions.
    override func tearDown() {
        cancellables = []
        super.tearDown()
    }
    
    /// Verifies that `loadProducts()` loads products successfully and sets state to `.completed`.
    func test_loadProducts_success() {
        // Arrange
        let mockRepo = MockProductRepository()
        let expectedProducts = [Product.mock()]
        mockRepo.productsToReturn = expectedProducts
        let useCase = FetchProductsUseCaseImpl(repository: mockRepo)
        let viewModel = ProductsListViewModel(fetchProductsUseCase: useCase)
        let expectation = self.expectation(description: "Products loaded")
        
        // Act
        viewModel.$viewState
            .filter { state in
                if case .completed = state { return true }
                return false
            }
            .sink { state in
                if case .completed(let products) = state {
                    XCTAssertEqual(products, expectedProducts)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.loadProducts()
        
        // Assert
        wait(for: [expectation], timeout: 5.0)
    }
    
    /// Verifies that `loadProducts()` sets view state to `.empty` when no products are fetched.
    func test_loadProducts_empty() {
        // Arrange
        let mockRepo = MockProductRepository()
        mockRepo.productsToReturn = []
        let useCase = FetchProductsUseCaseImpl(repository: mockRepo)
        let viewModel = ProductsListViewModel(fetchProductsUseCase: useCase)
        let expectation = self.expectation(description: "Empty state is emitted")
        
        // Act
        viewModel.$viewState
            .filter { state in
                if case .empty = state { return true }
                return false
            }
            .sink { state in
                if case .empty = state {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.loadProducts()
        
        // Assert
        wait(for: [expectation], timeout: 5.0)
    }
    
    /// Verifies that `loadProducts()` sets view state to `.error` when fetch fails.
    func test_loadProducts_failure() {
        // Arrange
        let mockRepo = MockProductRepository()
        let expectedError = URLError(.badServerResponse)
        mockRepo.errorToThrow = expectedError
        let useCase = FetchProductsUseCaseImpl(repository: mockRepo)
        let viewModel = ProductsListViewModel(fetchProductsUseCase: useCase)
        let expectation = self.expectation(description: "Error state is emitted")
        
        // Act
        viewModel.$viewState
            .filter { state in
                if case .error = state { return true }
                return false
            }
            .sink { state in
                if case .error(let message) = state {
                    XCTAssertEqual(message, expectedError.localizedDescription)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.loadProducts()
        
        // Assert
        wait(for: [expectation], timeout: 5.0)
    }
}

