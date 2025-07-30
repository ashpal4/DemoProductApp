//
//  APIClientTests.swift
//  DemoProductAppTests
//
//  Created by Ashish Pal on 18/06/25.
//

import XCTest
import Combine
@testable import DemoProductApp

/// Unit tests for the `APIClient` class, verifying both successful and failed HTTP responses.
final class APIClientTests: XCTestCase {
    
    /// Combine cancellables for memory management of publishers in tests.
    var cancellables = Set<AnyCancellable>()
    
    /// Called after each test method to clear the Combine subscriptions.
    override func tearDown() {
        cancellables = []
        super.tearDown()
    }
    
    /// Tests that the `APIClient` correctly decodes a successful HTTP response.
    ///
    /// This test sets up a mock `ProductResponseDTO`, encodes it into JSON, and verifies that
    /// the `APIClient` properly decodes it when receiving a 200 HTTP status code.
    func testRequest_SuccessfulResponse() throws {
        // Arrange
        let expectedProduct = ProductDTO(id: 1, title: "Mock", price: 10.0, thumbnail: "img", description: "desc")
        let responseDTO = ProductResponseDTO(products: [expectedProduct])
        let responseData = try JSONEncoder().encode(responseDTO)
        let baseURL = URL(string: "https://mockapi.com")!
        let endpoint = "/products"
        // Configure a custom session using MockURLProtocol
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        // Mock the HTTP 200 response with JSON data
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: baseURL.appendingPathComponent(endpoint), statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, responseData)
        }
        let client = APIClient(baseURL: baseURL, session: session)
        let expectation = XCTestExpectation(description: "Receive product response")
        // Act & Assert
        client.request(endpoint, responseType: ProductResponseDTO.self)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success, got error: \(error)")
                }
            }, receiveValue: { response in
                XCTAssertEqual(response.products.first?.id, expectedProduct.id)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1.0)
    }
    
    /// Tests that the `APIClient` correctly returns a failure when the HTTP response is invalid (e.g., 500).
    ///
    /// This simulates a server error and ensures that the client returns a failure instead of trying to decode an invalid response.
    func testRequest_FailureResponse() {
        // Arrange
        let baseURL = URL(string: "https://mockapi.com")!
        let endpoint = "/products"
        // Configure session with mock protocol
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        // Mock a 500 Internal Server Error response
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: baseURL.appendingPathComponent(endpoint), statusCode: 500, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }
        let client = APIClient(baseURL: baseURL, session: session)
        let expectation = XCTestExpectation(description: "Fails with error")
        // Act & Assert
        client.request(endpoint, responseType: ProductResponseDTO.self)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    if case APIClientError.httpError(let statusCode) = error {
                        XCTAssertEqual(statusCode, 500)
                        expectation.fulfill()
                    } else {
                        XCTFail("Expected HTTP error with status code 500")
                    }
                } else {
                    XCTFail("Expected failure")
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure")
            })
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1.0)
    }
}
