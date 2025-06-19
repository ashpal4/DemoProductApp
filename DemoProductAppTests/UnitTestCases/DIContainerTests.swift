//
//  DIContainerTests.swift
//  DemoProductAppTests
//
//  Created by Ashish Pal on 18/06/25.
//

import XCTest
import Combine
@testable import DemoProductApp

/// Tests for verifying dependency injection through `DIContainer`.
final class DIContainerTests: XCTestCase {
    
    /// Tests that the DI container provides non-nil use case and repository instances.
    func testDIContainer_ProvidesUseCase() {
        let container = DIContainer()
        let useCase = container.fetchProductsUseCase
        let repository = container.productRepository

        XCTAssertNotNil(useCase)
        XCTAssertNotNil(repository)
    }
}
