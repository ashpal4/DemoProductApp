//
//  APIClientError.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 30/07/25.
//

import Foundation

/// Custom error type to handle HTTP and decoding errors.
enum APIClientError: Error {
    case invalidURL
    case httpError(statusCode: Int)
    case decodingError(Error)
    case unknownError
}
