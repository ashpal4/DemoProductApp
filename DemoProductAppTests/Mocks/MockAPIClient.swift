//
//  MockAPIClient.swift
//  DemoProductAppTests
//
//  Created by Ashish Pal on 16/06/25.
//

import Foundation
import Combine
@testable import DemoProductApp

final class MockAPIClient: APIClientProtocol {
    var result: Result<Decodable, Error>?

    func request<T: Decodable>(_ request: URLRequest, responseType: T.Type) -> AnyPublisher<T, Error> {
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
