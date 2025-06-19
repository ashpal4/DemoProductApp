//
//  Constants.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Foundation

/// Contains constants related to API configuration.
enum APIConstants {
    /// Base URL of the API.
    static let baseURL = "https://dummyjson.com"
    
    /// Endpoint path to fetch the list of products.
    static let productsEndpoint = "/products"
}

/// Contains string constants used throughout the app.
enum StringConstants {
    /// Title for the products list screen.
    static let productsListTitle = "Products"
    
    /// Title for the product detail screen.
    static let productDetailTitle = "Product Detail"
}

/// Contains image name constants used in the UI.
enum ImageName {
    /// Default image name to use when no image is available.
    static let defaultImage = "photo"
}

/// Contains constants related to sizing in the UI.
enum SizeConstants {
    /// Spacing used in the product detail screen layout.
    static let productDetailSpacing: CGFloat = 16
    
    /// Height of the product image in the detail screen.
    static let productDetailImageHeight: CGFloat = 200
    
    /// Corner radius applied to the product image.
    static let productDetailImageCornerRadius: CGFloat = 12
}
