//
//  DIContainerTests.swift
//  DemoProductAppTests
//
//  Created by Ashish Pal on 18/06/25.
//

import XCTest
import Combine
@testable import DemoProductApp

final class DIContainerTests: XCTestCase {
    func testDIContainer_ProvidesUseCase() {
        let container = DIContainer()
        let useCase = container.fetchProductsUseCase
        let repository = container.productRepository

        XCTAssertNotNil(useCase)
        XCTAssertNotNil(repository)
    }
}
