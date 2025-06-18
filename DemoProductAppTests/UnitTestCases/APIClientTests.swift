//
//  APIClientTests.swift
//  DemoProductAppTests
//
//  Created by Ashish Pal on 18/06/25.
//

import XCTest
import Combine
@testable import DemoProductApp

final class APIClientTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    
    override func tearDown() {
        cancellables = []
        super.tearDown()
    }

    // MARK: - Success Test
    func testRequest_SuccessfulResponse() throws {
        let expectedProduct = ProductDTO(id: 1, title: "Mock", price: 10.0, thumbnail: "img", description: "desc")
        let responseDTO = ProductResponseDTO(products: [expectedProduct])
        let responseData = try JSONEncoder().encode(responseDTO)

        let url = URL(string: "https://mockapi.com/products")!
        let request = URLRequest(url: url)

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)

        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, responseData)
        }

        let client = APIClient(session: session)
        let expectation = XCTestExpectation(description: "Receive product response")

        client.request(request, responseType: ProductResponseDTO.self)
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

    // MARK: - Failure Test
    func testRequest_FailureResponse() {
        let url = URL(string: "https://mockapi.com/products")!
        let request = URLRequest(url: url)

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)

        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }

        let client = APIClient(session: session)
        let expectation = XCTestExpectation(description: "Fails with error")

        client.request(request, responseType: ProductResponseDTO.self)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure")
                }
            }, receiveValue: { _ in XCTFail("Expected failure") })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}
