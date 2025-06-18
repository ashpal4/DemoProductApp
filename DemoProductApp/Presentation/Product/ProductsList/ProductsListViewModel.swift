//
//  ProductsListViewModel.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Foundation
import Combine

final class ProductsListViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let fetchProductsUseCase: FetchProductsUseCase
    private var cancellables = Set<AnyCancellable>()

    init(fetchProductsUseCase: FetchProductsUseCase) {
        self.fetchProductsUseCase = fetchProductsUseCase
    }

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
