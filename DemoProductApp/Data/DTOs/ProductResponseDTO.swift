//
//  ProductResponseDTO.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Foundation

/// DTO representing the response structure from the product API.
///
/// This model is responsible for decoding API data and converting it to domain models.
struct ProductResponseDTO: Codable {

    /// The list of products returned by the API.
    let products: [ProductDTO]

    /// Converts the DTO response into domain models.
    ///
    /// - Returns: An array of domain-level `Product` models.
    func toDomainModel() -> [Product] {
        products.map { $0.toDomainModel() }
    }
}

