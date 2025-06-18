//
//  ProductsListViewModelTests.swift
//  DemoProductAppTests
//
//  Created by Ashish Pal on 16/06/25.
//

import XCTest
import Combine
@testable import DemoProductApp

@MainActor
final class ProductsListViewModelTests: XCTestCase {
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
    }

    func test_loadProducts_success() {
        // Arrange
        let mockRepo = MockProductRepository()
        mockRepo.productsToReturn = [Product.mock()]
        let useCase = FetchProductsUseCaseImpl(repository: mockRepo)
        let viewModel = ProductsListViewModel(fetchProductsUseCase: useCase)

        let expectation = XCTestExpectation(description: "Products loaded")

        // Act
        viewModel.$products
            .dropFirst()
            .sink { products in
                XCTAssertEqual(products.count, mockRepo.productsToReturn.count)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.loadProducts()

        // Assert
        wait(for: [expectation], timeout: 5.0)
    }

    func test_loadProducts_failure() {
        // Arrange
        let mockRepo = MockProductRepository()
        mockRepo.errorToThrow = URLError(.badServerResponse)
        let useCase = FetchProductsUseCaseImpl(repository: mockRepo)
        let viewModel = ProductsListViewModel(fetchProductsUseCase: useCase)
        
        let expectation = XCTestExpectation(description: "Expect error message to be set")
        
        viewModel.$errorMessage
            .dropFirst() // skip initial nil value
            .sink { error in
                if let error = error {
                    XCTAssertEqual(error, URLError(.badServerResponse).localizedDescription)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // Act
        viewModel.loadProducts()
        
        // Assert
        wait(for: [expectation], timeout: 5.0)
    }


}
