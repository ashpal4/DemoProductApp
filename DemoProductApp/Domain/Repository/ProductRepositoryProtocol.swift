//
//  ProductRepositoryProtocol.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Combine

/// A repository protocol that defines the contract for fetching products.
///
/// Typically implemented to abstract network or database access for product data.
protocol ProductRepositoryProtocol {
    
    /// Fetches a list of products asynchronously.
    ///
    /// - Returns: A publisher that emits an array of `Product` or an `Error`.
    func fetchProducts() -> AnyPublisher<[Product], Error>
}
