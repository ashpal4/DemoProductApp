//
//  ProductRepositoryImpl.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Foundation
import Combine

/// Concrete implementation of `ProductRepository` that fetches data using an API client.
final class ProductRepositoryImpl: ProductRepository {

    /// The API client used to perform network requests.
    private let apiClient: APIClientProtocol

    /// Initializes the repository with a given API client.
    ///
    /// - Parameter apiClient: The API client to be used. Defaults to an instance of `APIClient`.
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    /// Fetches the list of products from the remote API.
    ///
    /// - Returns: A publisher that emits an array of `Product` or an error.
    func fetchProducts() -> AnyPublisher<[Product], Error> {
        guard let url = URL(string: APIConstants.baseURL + APIConstants.productsEndpoint) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        let apiRequest = APIRequest(url: url, method: "GET")

        return apiClient.request(apiRequest.urlRequest, responseType: ProductResponseDTO.self)
            .map { $0.toDomainModel() }
            .eraseToAnyPublisher()
    }
}
