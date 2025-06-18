//
//  Product.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Foundation

struct Product: Identifiable, Hashable {
    let id: Int
    let title: String
    let price: Double
    let thumbnail: String
    let description: String
}

