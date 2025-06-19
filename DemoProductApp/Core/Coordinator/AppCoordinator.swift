//
//  AppCoordinator.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import SwiftUI

/// Coordinates navigation and view building in the application.
final class AppCoordinator: ObservableObject {
    /// The current navigation path used to manage the navigation stack.
    @Published var path = NavigationPath()
    
    /// Pushes a new screen onto the navigation stack.
    /// - Parameter screen: The screen to navigate to.
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    /// Pops the top screen from the navigation stack.
    func pop() {
        path.removeLast()
    }
    
    /// Pops all screens, returning to the root of the navigation stack.
    func popToRoot() {
        path.removeLast(path.count)
    }

    /// Builds a SwiftUI view based on the current screen.
    /// - Parameter screen: The screen to build.
    /// - Returns: A view representing the screen.
    @ViewBuilder
    func build(screen: Screen) -> some View {
        switch screen {
        case .productsList:
            ProductsListView(viewModel: ProductsListViewModel(
                fetchProductsUseCase: DIContainer().fetchProductsUseCase
            ))
        case .productDetail(let product):
            let viewModel = ProductDetailViewModel(product: product)
            ProductDetailView(viewModel: viewModel)
        }
    }
}
