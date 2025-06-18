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

    /// Sends a network request and decodes the response into a specified type.
    ///
    /// - Parameters:
    ///   - request: The `URLRequest` to be sent.
    ///   - responseType: The expected `Decodable` type of the response.
    ///
    /// - Returns: A publisher emitting the decoded object or an error.
    func request<T: Decodable>(_ request: URLRequest, responseType: T.Type) -> AnyPublisher<T, Error>
}
