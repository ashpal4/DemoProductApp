//
//  Constants.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Foundation

enum APIConstants {
    static let baseURL = "https://dummyjson.com"
    static let productsEndpoint = "/products"
}

enum StringConstants {
    static let productsListTitle = "Products"
    static let productDetailTitle = "Product Detail"
}

enum ImageName {
    static let defaultImage = "photo"
}

enum SizeConstants {
    static let productDetailSpacing: CGFloat = 16
    static let productDetailImageHeight: CGFloat = 200
    static let productDetailImageCornerRadius: CGFloat = 12
}
