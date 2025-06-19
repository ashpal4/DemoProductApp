//
//  MockFailingFetchProductsUseCase.swift
//  DemoProductAppSnapshotTests
//
//  Created by Ashish Pal on 19/06/25.
//

import Foundation
import Combine
@testable import DemoProductApp

/// A mock implementation of the `FetchProductsUseCaseProtocol` that simulates a failure scenario.
///
/// This mock use case is used for testing error handling in the `FetchProductsUseCase` when
/// a failure occurs, such as a network error or server issue.
final class MockFailingFetchProductsUseCase: FetchProductsUseCaseProtocol {
    
    // MARK: - Methods
    
    /// Simulates the execution of fetching products and returns a failure.
    ///
    /// This method uses Combine's `Fail` publisher to simulate a failure condition, specifically
    /// a network error (in this case, a bad server response). This is useful for testing how
    /// the application handles errors in the product fetching process.
    ///
    /// - Returns: A publisher that immediately fails with a `URLError` indicating a bad server response.
    func execute() -> AnyPublisher<[Product], Error> {
        // Use Combine's `Fail` to simulate an error scenario.
        Fail(error: URLError(.badServerResponse))
            // Erase the publisher's type information, so it conforms to `AnyPublisher`
            .eraseToAnyPublisher()
    }
}
