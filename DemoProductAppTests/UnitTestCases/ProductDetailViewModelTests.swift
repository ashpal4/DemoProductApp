//
//  ProductDetailViewModelTests.swift
//  DemoProductAppTests
//
//  Created by Ashish Pal on 16/06/25.
//

import XCTest
@testable import DemoProductApp

/// Unit tests for `ProductDetailViewModel`, verifying that it correctly exposes
/// product data and formats price values as expected.
final class ProductDetailViewModelTests: XCTestCase {
    
    /// Tests that the `thumbnail` property of the view model returns the correct URL string
    /// from the underlying product.
    func testThumbnailReturnsCorrectValue() {
        // Given
        let product = Product(id: 1,
                              title: "Test Product",
                              price: 19.99,
                              thumbnail: "https://example.com/image.png",
                              description: "A test product")
        let viewModel = ProductDetailViewModel(product: product)
        
        // Then
        XCTAssertEqual(viewModel.thumbnail, "https://example.com/image.png")
    }
    
    /// Tests that the `title` property of the view model returns the correct title
    /// from the underlying product.
    func testTitleReturnsCorrectValue() {
        // Given
        let product = Product(id: 1,
                              title: "Test Title",
                              price: 10.0,
                              thumbnail: "",
                              description: "")
        let viewModel = ProductDetailViewModel(product: product)
        
        // Then
        XCTAssertEqual(viewModel.title, "Test Title")
    }
    
    /// Tests that the `description` property of the view model returns the correct description
    /// from the underlying product.
    func testDescriptionReturnsCorrectValue() {
        // Given
        let product = Product(id: 1,
                              title: "",
                              price: 10.0,
                              thumbnail: "",
                              description: "Detailed description here.")
        let viewModel = ProductDetailViewModel(product: product)
        
        // Then
        XCTAssertEqual(viewModel.description, "Detailed description here.")
    }
    
    /// Tests that the `price` property returns a properly formatted string using
    /// the default currency symbol (`$`) and locale (`en_US`).
    func testPriceReturnsFormattedString_defaultCurrency() {
        // Given
        let product = Product(id: 1,
                              title: "",
                              price: 1234.56,
                              thumbnail: "",
                              description: "")
        let viewModel = ProductDetailViewModel(product: product)
        
        // Then
        let expected = "$1,234.56"
        XCTAssertEqual(viewModel.price, expected)
    }
    
    /// Tests the `currencyFormatted` function of `Double` directly with a custom currency symbol (`€`)
    /// and a French locale (`fr_FR`). Verifies that the formatted output contains the correct symbol
    /// and a valid numeric format.
    func testPriceReturnsFormattedString_customCurrencyAndLocale() {
        // Given
        let price = 1234.56
        let formatted = price.currencyFormatted(symbol: "€", locale: "fr_FR")
        
        // Then
        XCTAssertTrue(formatted.contains("1 234,56") || formatted.contains("1,234.56"))
        XCTAssertTrue(formatted.contains("€"))
    }
    
    /// Tests that the `currencyFormatted` function gracefully falls back to a default format
    /// when an invalid locale is provided. Ensures the output is still user-friendly and correctly
    /// prefixed with the currency symbol.
    func testCurrencyFormatted_fallbackOnFailure() {
        // Given
        let price = 999.99
        let result = price.currencyFormatted(symbol: "£", locale: "invalid_locale")

        // Then: Normalize non-breaking space for reliable comparison
        let normalizedResult = result.replacingOccurrences(of: "\u{00A0}", with: " ")
        XCTAssertEqual(normalizedResult, "£ 999.99")
    }
}

