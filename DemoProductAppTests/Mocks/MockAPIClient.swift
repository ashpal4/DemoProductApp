//
//  MockAPIClient.swift
//  DemoProductAppTests
//
//  Created by Ashish Pal on 16/06/25.
//

import Foundation
import Combine
@testable import DemoProductApp

/// A mock implementation of `APIClientProtocol` used for unit testing API calls without real network access.
final class MockAPIClient: APIClientProtocol {
    
    /// The result to return from the request (either success with data or failure with an error).
    var result: Result<Decodable, Error>?
    
    /// Simulates making an API request and returns a publisher with the provided result.
    ///
    /// - Parameters:
    ///   - endpoint: The endpoint path to be appended to the base URL (not used in logic).
    ///   - responseType: The expected response type.
    /// - Returns: A publisher emitting either the expected response or an error.
    func request<T: Decodable>(_ endpoint: String, responseType: T.Type) -> AnyPublisher<T, Error> {
        guard let result = result else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        switch result {
        case .success(let data):
            if let typedData = data as? T {
                return Just(typedData)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } else {
                return Fail(error: URLError(.cannotParseResponse)).eraseToAnyPublisher()
            }
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}

