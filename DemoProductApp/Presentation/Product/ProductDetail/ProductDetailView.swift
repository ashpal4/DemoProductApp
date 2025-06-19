//
//  ProductDetailView.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import SwiftUI

/// A view that displays detailed information about a product, including the product's image, title, and description.
struct ProductDetailView: View {
    
    // MARK: - Properties
    
    /// The view model responsible for providing the data needed for the product detail view.
    @StateObject var viewModel: ProductDetailViewModel
    
    // MARK: - Initialization
    
    /// Initializes the view with the provided `ProductDetailViewModel`.
    ///
    /// - Parameter viewModel: The `ProductDetailViewModel` instance that holds the product's details.
    init(viewModel: ProductDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: - Body
    
    var body: some View {
        // Scrollable view to display all content for product details
        ScrollView {
            VStack(spacing: SizeConstants.productDetailSpacing) {
                // Displays the product's thumbnail image with specific dimensions and corner radius.
                ThumbnailImageView(
                    imageUrl: viewModel.thumbnail,
                    imageWidth: SizeConstants.productDetailImageHeight,
                    imageHeight: SizeConstants.productDetailImageHeight,
                    imageCornerRadius: SizeConstants.productDetailImageCornerRadius
                )
                
                // Displays the product's title.
                titleView(title: viewModel.title)
                
                // Displays the product's description.
                descriptionView(description: viewModel.description)
            }
            .padding() // Adds padding around the entire content
        }
        // Sets the navigation bar title for the detail view.
        .navigationTitle(StringConstants.productDetailTitle)
    }
}

// MARK: - Helper Views

extension ProductDetailView {
    
    /// A view displaying the product's title.
    ///
    /// - Parameter title: The title of the product.
    /// - Returns: A `Text` view displaying the product title.
    func titleView(title: String) -> some View {
        Text(title)
            .font(.title) // Displays the title in a large font size
    }
    
    /// A view displaying the product's price formatted as currency.
    ///
    /// - Parameter price: The price of the product.
    /// - Returns: A `Text` view displaying the formatted price.
    func priceView(price: Double) -> some View {
        Text(price.currencyFormatted()) // Formats the price as currency.
            .font(.headline) // Displays the price in a headline style
    }
    
    /// A view displaying the product's description.
    ///
    /// - Parameter description: The description of the product.
    /// - Returns: A `Text` view displaying the product description.
    func descriptionView(description: String) -> some View {
        Text(description)
            .font(.body) // Displays the description in the body font style
    }
}
