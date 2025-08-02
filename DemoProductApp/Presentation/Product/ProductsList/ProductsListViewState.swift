//
//  ProductsListViewState.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 18/06/25.
//

import Foundation

/// Represents the UI state of the `ProductsListView`, excluding the data itself.
enum ProductsListViewState: Equatable {
    
    /// Indicates that the product list has been successfully loaded.
    /// - Parameter products: An array of `Product` objects representing the loaded products.
    case completed([Product])
    
    /// Indicates that there are no products to display.
    case empty
    
    /// Indicates that products are currently being loaded.
    case loading

    /// Indicates that an error has occurred while loading products.
    /// - Parameter message: A human-readable error message describing the failure.
    case error(String)
}
