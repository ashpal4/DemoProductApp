//
//  AppCoordinatorTests.swift
//  DemoProductAppTests
//
//  Created by Ashish Pal on 18/06/25.
//

import XCTest
import Combine
@testable import DemoProductApp

final class AppCoordinatorTests: XCTestCase {
    func testPushScreen() {
        let coordinator = AppCoordinator()
        XCTAssertEqual(coordinator.path.count, 0)
        coordinator.push(.productsList)
        XCTAssertEqual(coordinator.path.count, 1)
    }

    func testPopScreen() {
        let coordinator = AppCoordinator()
        coordinator.push(.productsList)
        coordinator.push(.productsList)
        coordinator.pop()
        XCTAssertEqual(coordinator.path.count, 1)
    }

    func testPopToRoot() {
        let coordinator = AppCoordinator()
        coordinator.push(.productsList)
        coordinator.push(.productsList)
        coordinator.popToRoot()
        XCTAssertEqual(coordinator.path.count, 0)
    }
}
