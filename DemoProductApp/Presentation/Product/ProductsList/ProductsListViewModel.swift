//
//  ProductsListViewModel.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Foundation
import Combine

/// ViewModel responsible for handling product listing logic and UI state management.
final class ProductsListViewModel: ObservableObject {
    
    /// Represents the current UI state of the view, such as loading or error.
    @Published var viewState: ProductsListViewState = .loading
    
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
    
    /// Triggers the product loading process by updating the view state and executing the use case.
    ///
    /// Updates `viewState` to `.loading`, and then transitions it to `.idle` or `.error` depending on the result.
    /// On successful completion, the fetched products are stored in the `products` array.
    func loadProducts() {
        viewState = .loading
        
        fetchProductsUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.viewState = .error(error.localizedDescription)
                }
            } receiveValue: { [weak self] products in
                if products.isEmpty {
                    self?.viewState = .empty
                } else {
                    self?.viewState = .completed(products)
                }
            }
            .store(in: &cancellables)
    }
}
