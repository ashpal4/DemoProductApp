//
//  Product.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Foundation

/// A model representing a product.
struct Product: Identifiable, Hashable {
    /// Unique identifier for the product.
    let id: Int
    
    /// Name or title of the product.
    let title: String
    
    /// Price of the product.
    let price: Double
    
    /// URL or name of the thumbnail image for the product.
    let thumbnail: String
    
    /// Description of the product.
    let description: String
}
