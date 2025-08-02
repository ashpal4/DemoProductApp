//
//  MockLoadingFetchProductsUseCase.swift
//  DemoProductAppSnapshotTests
//
//  Created by Ashish Pal on 02/08/25.
//

import Foundation
import Combine
@testable import DemoProductApp

/// A mock implementation of the FetchProductsUseCaseProtocol that simulates a loading state.
class MockLoadingFetchProductsUseCase: FetchProductsUseCaseProtocol {
    func execute() -> AnyPublisher<[Product], Error> {
        // Simulate a delay to represent loading
        return Just([])
            .delay(for: .seconds(2), scheduler: DispatchQueue.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

