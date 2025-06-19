//
//  MainApp.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import SwiftUI

/// The main entry point for the application, defining the root scene and initial view.
@main
struct MainApp: App {
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            AppCoordinatorView() // Initial view to launch when the app starts.
        }
    }
}
