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
    
    /// The base URL for the API.
    private let baseURL: URL
    /// Initializes the API client with a given URL session and base URL.
    ///
    /// - Parameters:
    ///   - baseURL: The base URL for the API.
    ///   - session: The `URLSession` instance to use. Defaults to `.shared`.
    init(baseURL: URL, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }
    
    /// Sends a request and decodes the response into the specified type.
    ///
    /// - Parameters:
    ///   - endpoint: The endpoint path to be appended to the base URL.
    ///   - responseType: The type into which the response will be decoded.
    ///
    /// - Returns: A publisher that emits the decoded object or an error.
    func request<T: Decodable>(_ endpoint: String, responseType: T.Type) -> AnyPublisher<T, Error> {
        guard let url = URL(string: endpoint, relativeTo: baseURL) else {
            return Fail(error: APIClientError.invalidURL).eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: url)
        
        return session.dataTaskPublisher(for: request)
            .tryMap { result in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw APIClientError.unknownError
                }
                
                switch httpResponse.statusCode {
                case 200...299:
                    let decoder = JSONDecoder()
                    do {
                        return try decoder.decode(T.self, from: result.data)
                    } catch {
                        throw APIClientError.decodingError(error)
                    }
                default:
                    throw APIClientError.httpError(statusCode: httpResponse.statusCode)
                }
            }
            .mapError { error in
                if let apiClientError = error as? APIClientError {
                    return apiClientError
                } else {
                    return APIClientError.unknownError
                }
            }
            .eraseToAnyPublisher()
    }
}

