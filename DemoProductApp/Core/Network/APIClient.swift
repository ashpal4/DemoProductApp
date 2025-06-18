//
//  APIClient.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Foundation
import Combine

final class APIClient: APIClientProtocol {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

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

