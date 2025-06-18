//
//  ProductResponseDTO.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Foundation

struct ProductResponseDTO: Codable {
    let products: [ProductDTO]

    func toDomainModel() -> [Product] {
        products.map { $0.toDomainModel() }
    }
}
