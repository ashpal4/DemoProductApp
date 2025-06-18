//
//  Double+CurrencyFormattingTests.swift
//  DemoProductAppTests
//
//  Created by Ashish Pal on 16/06/25.
//

import XCTest
@testable import DemoProductApp

final class DoubleCurrencyFormattingTests: XCTestCase {

    func testCurrencyFormatted_defaultSymbolAndLocale() {
        let value: Double = 1234.56
        let formatted = value.currencyFormatted()
        XCTAssertEqual(formatted, "$1,234.56")
    }

    func testCurrencyFormatted_withEuroSymbolAndGermanLocale() {
        let value: Double = 1234.56
        let formatted = value.currencyFormatted(symbol: "€", locale: "de_DE")
        XCTAssertEqual(formatted, "1.234,56 €") // Note the comma and period reversal
    }

    func testCurrencyFormatted_withZero() {
        let value: Double = 0.0
        let formatted = value.currencyFormatted()
        XCTAssertEqual(formatted, "$0.00")
    }
}
