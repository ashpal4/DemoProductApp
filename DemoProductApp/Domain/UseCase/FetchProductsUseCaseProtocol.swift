//
//  FetchProductsUseCaseProtocol.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Combine

/// A use case protocol for executing product fetching logic.
///
/// This represents the business logic layer and acts as an abstraction
/// between the view model and data layer.
protocol FetchProductsUseCaseProtocol {
    /// Executes the use case to fetch products.
    ///
    /// - Returns: A publisher that emits a list of `Product` or an `Error`.
    func execute() -> AnyPublisher<[Product], Error>
}
