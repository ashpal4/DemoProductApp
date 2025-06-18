//
//  ProductsListViewModel.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Foundation
import Combine

final class ProductsListViewModel: ObservableObject {
    
    /// The list of products to be displayed.
    @Published var products: [Product] = []
    
    /// Indicates whether products loading is in progress.
    @Published var isLoading = false
    
    /// An error message to be displayed if product loading fails.
    @Published var errorMessage: String?

    /// Use case that handles the logic for fetching products.
    private let fetchProductsUseCase: FetchProductsUseCaseProtocol
    
    /// A set used to store Combine cancellables for managing subscriptions.
    private var cancellables = Set<AnyCancellable>()

    /// Initializes a new instance of `ProductsListViewModel`.
    ///
    /// - Parameter fetchProductsUseCase: The use case responsible for fetching the list of products.
    init(fetchProductsUseCase: FetchProductsUseCaseProtocol) {
        self.fetchProductsUseCase = fetchProductsUseCase
    }

    /// Initiates the product loading process.
    ///
    /// This method sets the loading flag to `true`, clears any previous error message,
    /// and executes the `fetchProductsUseCase`. It updates the `products` list on success,
    /// or the `errorMessage` on failure. All UI-bound state updates are dispatched on the main thread.
    func loadProducts() {
        isLoading = true
        errorMessage = nil

        fetchProductsUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] products in
                self?.products = products
            }
            .store(in: &cancellables)
    }
}
