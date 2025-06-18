//
//  APIClientProtocol.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Combine
import Foundation

protocol APIClientProtocol {
    func request<T: Decodable>(_ request: URLRequest, responseType: T.Type) -> AnyPublisher<T, Error>
}
