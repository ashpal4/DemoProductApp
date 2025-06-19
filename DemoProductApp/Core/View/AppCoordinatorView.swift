//
//  AppCoordinatorView.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import SwiftUI

/// A view responsible for managing navigation and coordinating different screens of the app.
struct AppCoordinatorView: View {
    
    // MARK: - Properties
    
    /// The coordinator that manages the navigation stack and screen transitions.
    @StateObject private var coordinator = AppCoordinator()

    // MARK: - Body
    
    var body: some View {
        // A NavigationStack is used to manage the view hierarchy and navigation path.
        NavigationStack(path: $coordinator.path) {
            
            // Build the initial screen view based on the `productsList` screen.
            coordinator.build(screen: .productsList)
            
            // Define the navigation destination for each screen type (`Screen`).
            .navigationDestination(for: Screen.self) { screen in
                // Use the coordinator to build and navigate to the appropriate screen.
                coordinator.build(screen: screen)
            }
        }
        // Inject the `coordinator` as an environment object for child views to access.
        .environmentObject(coordinator)
    }
}
