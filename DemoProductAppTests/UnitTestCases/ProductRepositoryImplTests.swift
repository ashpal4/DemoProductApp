//
//  ProductRepositoryImplTests.swift
//  DemoProductAppTests
//
//  Created by Ashish Pal on 16/06/25.
//

import XCTest
import Combine
@testable import DemoProductApp

/// Unit tests for `ProductRepositoryImpl`, verifying the behavior of fetching products from the API.
final class ProductRepositoryImplTests: XCTestCase {
    
    /// A set to store cancellables for Combine subscriptions.
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Teardown
    
    /// Called after each test method to clear the Combine subscriptions.
    override func tearDown() {
        cancellables = []
        super.tearDown()
    }
    
    /// Verifies that the repository correctly handles a successful API response and returns products.
    func test_fetchProducts_success() {
        
        // Arrange
        
        // Prepare mock product data to simulate a successful API response.
        let mockDTO = ProductResponseDTO(products: [
            ProductDTO(
                id: 1,
                title: "Test Product",
                price: 99.99,
                thumbnail: "https://example.com/image.jpg",
                description: "Test description"
            )
        ])
        
        // Mock API client setup with a successful result.
        let mockAPIClient = MockAPIClient()
        mockAPIClient.result = .success(mockDTO)

        // Create the repository instance using the mock API client.
        let repository = ProductRepositoryImpl(apiClient: mockAPIClient)

        // Define an expectation for the test to fulfill upon successful data fetch.
        let expectation = XCTestExpectation(description: "Fetch products success")
        
        // Act
        
        // Call the repository's `fetchProducts` method and observe the result.
        repository.fetchProducts()
            .sink(receiveCompletion: { completion in
                // Handle unexpected failures.
                if case .failure = completion {
                    XCTFail("Expected success but got failure")
                }
            }, receiveValue: { products in
                // Assert that the fetched products match the expected values.
                XCTAssertEqual(products.count, 1)
                XCTAssertEqual(products.first?.title, "Test Product")
                XCTAssertEqual(products.first?.description, "Test description")
                
                // Fulfill the expectation to indicate that the test has completed successfully.
                expectation.fulfill()
            })
            .store(in: &cancellables)

        // Assert
        
        // Wait for the expectation to be fulfilled within a timeout period.
        wait(for: [expectation], timeout: 1)
    }

    /// Verifies that the repository correctly handles a failed API response and returns an error.
    func test_fetchProducts_failure() {
        
        // Arrange
        
        // Set up a mock API client with a failure response.
        let mockAPIClient = MockAPIClient()
        mockAPIClient.result = .failure(URLError(.badServerResponse))

        // Create the repository instance using the mock API client.
        let repository = ProductRepositoryImpl(apiClient: mockAPIClient)

        // Define an expectation for the test to fulfill upon receiving an error.
        let expectation = XCTestExpectation(description: "Fetch products failure")
        
        // Act
        
        // Call the repository's `fetchProducts` method and observe the result.
        repository.fetchProducts()
            .sink(receiveCompletion: { completion in
                // Assert that the completion contains an error.
                if case .failure(let error) = completion {
                    XCTAssertNotNil(error)
                    // Fulfill the expectation when an error occurs.
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure but got success")
                }
            }, receiveValue: { _ in
                // This block should not be called in the failure case.
                XCTFail("Expected failure but got value")
            })
            .store(in: &cancellables)

        // Assert
        
        // Wait for the expectation to be fulfilled within a timeout period.
        wait(for: [expectation], timeout: 1)
    }
}
