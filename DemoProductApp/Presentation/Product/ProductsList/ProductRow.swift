//
//  ProductRow.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 20/06/25.
//

import SwiftUI

/// A view that displays a single row representing a product, including its thumbnail, title, and price.
/// Tapping the row navigates to the product's detail view.
struct ProductRow: View {
    
    // MARK: - Properties
    
    /// The product to be displayed in the row.
    let product: Product
    
    /// The app coordinator used to handle navigation actions.
    @EnvironmentObject private var coordinator: AppCoordinator
    
    // MARK: - Body
    
    var body: some View {
        /// A button that navigates to the product detail screen when tapped.
        Button {
            // Navigates to the product detail screen using the app coordinator.
            coordinator.push(.productDetail(product: product))
        } label: {
            HStack {
                // Displays the product's thumbnail image.
                ThumbnailImageView(imageUrl: product.thumbnail)
                
                // Displays the product's title and price in a vertical stack.
                VStack(alignment: .leading) {
                    titleView(title: product.title)
                    priceView(price: product.price)
                }
            }
        }
    }
}

// MARK: - Helper Views

extension ProductRow {
    
    /// A view displaying the product's title.
    ///
    /// - Parameter title: The title of the product.
    /// - Returns: A `Text` view displaying the product title.
    func titleView(title: String) -> some View {
        Text(title)
            .font(.headline) // Applies a headline font style for emphasis.
            .foregroundColor(.primary) // Uses the primary color for better contrast.
    }
    
    /// A view displaying the product's price, formatted as currency.
    ///
    /// - Parameter price: The price of the product.
    /// - Returns: A `Text` view displaying the formatted price.
    func priceView(price: Double) -> some View {
        Text(price.currencyFormatted()) // Formats the price as currency.
            .font(.subheadline) // Applies a smaller font size for the price.
            .foregroundColor(.gray) // Uses a gray color to de-emphasize the price.
    }
}

