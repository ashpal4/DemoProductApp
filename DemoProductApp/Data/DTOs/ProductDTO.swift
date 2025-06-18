//
//  ProductDTO.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Foundation

struct ProductDTO: Codable {
    let id: Int
    let title: String
    let price: Double
    let thumbnail: String
    let description: String

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
