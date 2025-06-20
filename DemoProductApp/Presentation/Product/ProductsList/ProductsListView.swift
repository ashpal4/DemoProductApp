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
            ProductRow(product: product)
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
