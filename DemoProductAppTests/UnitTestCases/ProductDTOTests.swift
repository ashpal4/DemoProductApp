//
//  ProductDTOTests.swift
//  DemoProductAppTests
//
//  Created by Ashish Pal on 16/06/25.
//

import XCTest
@testable import DemoProductApp

/// Unit tests for `ProductDTO` and `ProductResponseDTO` model conversions and decoding.
final class ProductDTOTests: XCTestCase {
    
    /// Tests conversion of a single `ProductDTO` to domain model.
    func test_ProductDTO_toDomainModel() {
        let dto = ProductDTO(id: 1, title: "Sample", price: 99.99, thumbnail: "https://example.com/image.jpg", description: "Sample description")
        let domain = dto.toDomainModel()

        XCTAssertEqual(domain.id, dto.id)
        XCTAssertEqual(domain.title, dto.title)
        XCTAssertEqual(domain.price, dto.price)
        XCTAssertEqual(domain.thumbnail, dto.thumbnail)
        XCTAssertEqual(domain.description, dto.description)
    }

    /// Tests conversion of a `ProductResponseDTO` containing multiple products to domain models.
    func test_ProductResponseDTO_toDomainModel() throws {
        let json = """
        {
            "products": [
                {
                    "id": 1,
                    "title": "Test Product",
                    "price": 49.99,
                    "thumbnail": "https://test.com/image.png",
                    "description": "A test product"
                },
                {
                    "id": 2,
                    "title": "Another Product",
                    "price": 29.99,
                    "thumbnail": "https://test.com/image2.png",
                    "description": "Another test product"
                }
            ]
        }
        """.data(using: .utf8)!

        let dto = try JSONDecoder().decode(ProductResponseDTO.self, from: json)
        let domainModels = dto.toDomainModel()

        XCTAssertEqual(domainModels.count, 2)
        XCTAssertEqual(domainModels[0].title, "Test Product")
        XCTAssertEqual(domainModels[1].price, 29.99)
    }

    /// Tests decoding a single `ProductDTO` from JSON.
    func test_ProductDTO_decodingFromJSON() throws {
        let json = """
        {
            "id": 10,
            "title": "Mock Item",
            "price": 10.5,
            "thumbnail": "http://image.com/img.png",
            "description": "Mock Desc"
        }
        """.data(using: .utf8)!

        let dto = try JSONDecoder().decode(ProductDTO.self, from: json)

        XCTAssertEqual(dto.id, 10)
        XCTAssertEqual(dto.title, "Mock Item")
        XCTAssertEqual(dto.price, 10.5)
        XCTAssertEqual(dto.thumbnail, "http://image.com/img.png")
        XCTAssertEqual(dto.description, "Mock Desc")
    }
}
