//
//  ProductDetailViewModel.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Foundation

final class ProductDetailViewModel: ObservableObject {
    
    /// The underlying product being displayed.
    @Published var product: Product

    /// Initializes a new `ProductDetailViewModel` with a given product.
    ///
    /// - Parameter product: The product to be displayed in the detail view.
    init(product: Product) {
        self.product = product
    }
}

extension ProductDetailViewModel {
    
    /// The URL string of the product's thumbnail image.
    var thumbnail: String {
        product.thumbnail
    }
    
    /// The title of the product.
    var title: String {
        product.title
    }
    
    /// The description of the product.
    var description: String {
        product.description
    }
    
    /// The price of the product, formatted as a currency string.
    var price: String {
        product.price.currencyFormatted()
    }
}
