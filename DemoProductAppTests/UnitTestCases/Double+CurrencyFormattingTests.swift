//
//  Double+CurrencyFormattingTests.swift
//  DemoProductAppTests
//
//  Created by Ashish Pal on 16/06/25.
//

import XCTest
@testable import DemoProductApp

/// Unit tests for currency formatting extension on `Double`.
final class DoubleCurrencyFormattingTests: XCTestCase {

    /// Verifies default currency formatting with symbol `$` and locale `en_US`.
    func testCurrencyFormatted_defaultSymbolAndLocale() {
        let value: Double = 1234.56
        let formatted = value.currencyFormatted()
        XCTAssertEqual(formatted, "$1,234.56")
    }

    /// Verifies currency formatting using Euro symbol and German locale.
    func testCurrencyFormatted_withEuroSymbolAndGermanLocale() {
        let value: Double = 1234.56
        let formatted = value.currencyFormatted(symbol: "€", locale: "de_DE")
        XCTAssertEqual(formatted, "1.234,56 €")
    }

    /// Verifies formatting behavior when value is zero.
    func testCurrencyFormatted_withZero() {
        let value: Double = 0.0
        let formatted = value.currencyFormatted()
        XCTAssertEqual(formatted, "$0.00")
    }
}
