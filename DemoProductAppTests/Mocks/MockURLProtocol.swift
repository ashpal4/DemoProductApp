//
//  MockURLProtocol.swift
//  DemoProductAppTests
//
//  Created by Ashish Pal on 18/06/25.
//

import Foundation

/// A custom URL protocol used to mock network requests in URLSession for testing.
final class MockURLProtocol: URLProtocol {
    
    /// A handler used to return mock responses for intercepted requests.
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?

    /// Determines whether this protocol can handle the given request. Always returns true.
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    /// Returns the canonical version of the request (unmodified in this case).
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    /// Starts the loading process by using the `requestHandler` to simulate a network response.
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            fatalError("No handler set")
        }

        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    /// Stops the loading process. No-op in this mock implementation.
    override func stopLoading() {}
}
