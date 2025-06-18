//
//  ProductDTO.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Foundation

/// A Data Transfer Object (DTO) representing a product retrieved from the API.
///
/// `ProductDTO` conforms to `Codable` and mirrors the structure of the product
/// data returned by the remote server. It includes a method to convert itself
/// into a domain-level `Product` model used throughout the app.
struct ProductDTO: Codable {

    /// The unique identifier for the product.
    let id: Int

    /// The title or name of the product.
    let title: String

    /// The price of the product.
    let price: Double

    /// The URL string of the product’s thumbnail image.
    let thumbnail: String

    /// A detailed description of the product.
    let description: String

    /// Converts the `ProductDTO` into a domain model `Product`.
    ///
    /// - Returns: A `Product` instance containing the same data.
    func toDomainModel() -> Product {
        Product(
            id: id,
            title: title,
            price: price,
            thumbnail: thumbnail,
            description: description
        )
    }
}

