//
//  AppCoordinatorTests.swift
//  DemoProductAppTests
//
//  Created by Ashish Pal on 18/06/25.
//

import XCTest
import Combine
@testable import DemoProductApp

/// Unit tests for the `AppCoordinator`, verifying navigation path operations such as push, pop, and popToRoot.
final class AppCoordinatorTests: XCTestCase {
    
    /// Verifies that pushing a screen adds it to the navigation path.
    func testPushScreen() {
        // Arrange
        let coordinator = AppCoordinator()
        
        // Assert initial path is empty
        XCTAssertEqual(coordinator.path.count, 0)
        
        // Act
        coordinator.push(.productsList)
        
        // Assert one screen is now in the path
        XCTAssertEqual(coordinator.path.count, 1)
    }
    
    /// Verifies that popping a screen removes the last screen from the navigation path.
    func testPopScreen() {
        // Arrange
        let coordinator = AppCoordinator()
        coordinator.push(.productsList)
        coordinator.push(.productsList)
        
        // Act
        coordinator.pop()
        
        // Assert path contains one screen after pop
        XCTAssertEqual(coordinator.path.count, 1)
    }
    
    /// Verifies that `popToRoot()` clears all screens from the navigation path.
    func testPopToRoot() {
        // Arrange
        let coordinator = AppCoordinator()
        coordinator.push(.productsList)
        coordinator.push(.productsList)
        
        // Act
        coordinator.popToRoot()
        
        // Assert path is empty after popping to root
        XCTAssertEqual(coordinator.path.count, 0)
    }
}

