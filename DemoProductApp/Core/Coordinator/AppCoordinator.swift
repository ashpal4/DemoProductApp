//
//  AppCoordinator.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import SwiftUI

final class AppCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    let productsListViewModel = ProductsListViewModel(fetchProductsUseCase: DIContainer().fetchProductsUseCase)

    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }

    @ViewBuilder
    func build(screen: Screen) -> some View {
        switch screen {
        case .productsList:
            ProductsListView(viewModel: productsListViewModel)
        case .productDetail(let product):
            let viewModel = ProductDetailViewModel(product: product)
            ProductDetailView(viewModel: viewModel)
        }
    }
}
