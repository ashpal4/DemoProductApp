//
//  Route.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Foundation

enum Screen: Hashable {
    var id: String {
        switch self {
        case .productsList:
            return "productsList"
        case .productDetail(let product):
            return "productDetail_\(product.id)"
        }
    }
    
    case productsList
    case productDetail(product: Product)
}
