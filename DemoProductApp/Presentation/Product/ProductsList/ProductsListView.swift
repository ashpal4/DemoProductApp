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
    
    /// The body of the view, defining the UI layout and behavior.
    var body: some View {
        VStack {
            // Switches between different UI states based on the current view state.
            switch viewModel.viewState {
            case .completed(let products):
                // Displays a list of products when loading is completed.
                List(products) { product in
                    ProductRow(product: product) // Represents each product as a row in the list.
                }
            case .empty:
                // Displays a message when there are no products available.
                Text("No products available")
            case .loading:
                // Shows a loading spinner while fetching products.
                ProgressView()
            case .error(let message):
                // Shows an error message in case of a failure.
                Text(message)
                    .foregroundColor(.red) // Sets the text color to red for error indication.
                    .padding() // Adds padding around the error message.
            }
        }
        // Loads products when the view appears if the list is empty.
        .onAppear {
            viewModel.loadProducts()
        }
        // Sets the navigation title for the view.
        .navigationTitle(StringConstants.productsListTitle)
    }
}
