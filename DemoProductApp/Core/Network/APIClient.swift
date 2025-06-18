//
//  APIClient.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Foundation
import Combine

/// A concrete implementation of `APIClientProtocol` that uses `URLSession` to perform network requests.
final class APIClient: APIClientProtocol {

    /// The URL session used for performing network requests.
    private let session: URLSession

    /// Initializes the API client with a given URL session.
    ///
    /// - Parameter session: The `URLSession` instance to use. Defaults to `.shared`.
    init(session: URLSession = .shared) {
        self.session = session
    }

    /// Sends a request and decodes the response into the specified type.
    ///
    /// - Parameters:
    ///   - request: The `URLRequest` to be executed.
    ///   - responseType: The type into which the response will be decoded.
    ///
    /// - Returns: A publisher that emits the decoded object or an error.
    func request<T: Decodable>(_ request: URLRequest, responseType: T.Type) -> AnyPublisher<T, Error> {
        return session.dataTaskPublisher(for: request)
            .tryMap { result in
                let decoder = JSONDecoder()
                guard let httpResponse = result.response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return try decoder.decode(T.self, from: result.data)
            }
            .eraseToAnyPublisher()
    }
}
