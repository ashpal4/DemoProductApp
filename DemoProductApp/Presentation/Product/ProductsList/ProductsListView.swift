//
//  ProductsListView.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import SwiftUI

/// A view that displays a list of products, allowing the user to tap on a product to navigate to its detail screen.
struct ProductsListView: View {
    
    // MARK: - Properties
    
    /// The coordinator responsible for navigating between views.
    @EnvironmentObject private var coordinator: AppCoordinator
    
    /// The view model responsible for managing the state and logic of the products list.
    @StateObject private var viewModel: ProductsListViewModel
    
    // MARK: - Initialization
    
    /// Initializes the view with the provided view model.
    ///
    /// - Parameter viewModel: The `ProductsListViewModel` instance that provides data and logic for the list of products.
    init(viewModel: ProductsListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: - Body
    
    var body: some View {
        // A list displaying all the products from the view model.
        List(viewModel.products) { product in
            Button {
                // Navigates to the product detail screen when a product is tapped.
                coordinator.push(.productDetail(product: product))
            } label: {
                HStack {
                    // Displays the product thumbnail image.
                    ThumbnailImageView(imageUrl: product.thumbnail)
                    
                    // Displays the product's title and price.
                    VStack(alignment: .leading) {
                        titleView(title: product.title)
                        priceView(price: product.price)
                    }
                }
            }
        }
        // Loads products when the view appears if the list is empty.
        .onAppear {
            if viewModel.products.isEmpty {
                viewModel.loadProducts()
            }
        }
        // Displays an overlay based on the view state.
        .overlay {
            overlayView
        }
        // Sets the navigation title.
        .navigationTitle(StringConstants.productsListTitle)
    }
}

extension ProductsListView {
    
    /// A view displaying the product's title.
    ///
    /// - Parameter title: The title of the product.
    /// - Returns: A `Text` view displaying the product title.
    func titleView(title: String) -> some View {
        Text(title)
    }
    
    /// A view displaying the product's price.
    ///
    /// - Parameter price: The price of the product.
    /// - Returns: A `Text` view displaying the formatted price.
    func priceView(price: Double) -> some View {
        Text(price.currencyFormatted()) // Formats the price as currency.
            .font(.subheadline)
            .foregroundColor(.gray)
    }
    
    // MARK: - Overlay View
    
    /// A view that shows different states based on the view model's `viewState`.
    ///
    /// The overlay displays a loading indicator, an error message, or nothing depending on the current state.
    @ViewBuilder
    var overlayView: some View {
        switch viewModel.viewState {
            case .loading:
                ProgressView() // Shows a loading spinner while fetching products.
            case .error(let message):
                Text(message) // Shows an error message in case of a failure.
                    .foregroundColor(.red)
                    .padding()
            default:
                EmptyView() // Displays nothing if the state is idle or other.
        }
    }
}

