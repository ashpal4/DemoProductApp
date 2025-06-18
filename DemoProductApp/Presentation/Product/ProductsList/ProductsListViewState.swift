//
//  ProductsListViewState.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 18/06/25.
//

import Foundation

/// Represents the UI state of the `ProductsListView`, excluding the data itself.
enum ProductsListViewState: Equatable {
    
    /// The default, idle state where no loading or error is occurring.
    case idle

    /// Indicates that products are currently being loaded.
    case loading

    /// Indicates that an error has occurred while loading products.
    /// - Parameter message: A human-readable error message describing the failure.
    case error(String)
}
