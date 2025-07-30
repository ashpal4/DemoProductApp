//
//  APIClientProtocol.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Combine
import Foundation

/// A protocol that defines the interface for making API requests.
///
/// `APIClientProtocol` abstracts the underlying networking logic and provides
/// a generic `request` method that publishes a decoded response.
protocol APIClientProtocol {
    /// Sends a network request to a specified endpoint and decodes the response into a specified type.
    ///
    /// - Parameters:
    ///   - endpoint: The endpoint path to be appended to the base URL.
    ///   - responseType: The expected `Decodable` type of the response.
    ///
    /// - Returns: A publisher emitting the decoded object or an error.
    func request<T: Decodable>(_ endpoint: String, responseType: T.Type) -> AnyPublisher<T, Error>
}
