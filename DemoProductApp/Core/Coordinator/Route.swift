//
//  Route.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Foundation

/// Represents the possible screens in the app's navigation.
enum Screen: Hashable {
    /// The screen displaying the list of products.
    case productsList

    /// The screen displaying the details of a selected product.
    case productDetail(product: Product)
}
