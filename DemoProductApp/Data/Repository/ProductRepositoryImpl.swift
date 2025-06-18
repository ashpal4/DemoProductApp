//
//  ProductRepositoryImpl.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Foundation
import Combine

final class ProductRepositoryImpl: ProductRepository {
    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }

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
