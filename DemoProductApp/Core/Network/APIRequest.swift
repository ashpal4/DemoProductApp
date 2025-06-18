//
//  APIRequest.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 17/06/25.
//

import Foundation

/// A lightweight wrapper around `URLRequest` for representing API calls.
struct APIRequest {

    /// The URL of the request.
    let url: URL

    /// The HTTP method to use, e.g., `.get` or `.post`.
    let method: HTTPMethod

    /// The constructed `URLRequest` from the provided URL and method.
    var urlRequest: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
