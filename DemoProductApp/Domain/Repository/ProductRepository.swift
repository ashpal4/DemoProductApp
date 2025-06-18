//
//  ProductRepository.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Combine

protocol ProductRepository {
    func fetchProducts() -> AnyPublisher<[Product], Error>
}
