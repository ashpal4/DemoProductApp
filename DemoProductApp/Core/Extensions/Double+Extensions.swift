//
//  Double+Extensions.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Foundation

/// An extension to the `Double` type that adds currency formatting functionality.
extension Double {
    
    /// Formats the double value as a currency string.
    ///
    /// - Parameters:
    ///   - symbol: The currency symbol to use in the formatted output (e.g., "$", "€", "¥").
    ///             Defaults to `"$"`.
    ///   - locale: A locale identifier string (e.g., "en_US", "fr_FR") to format the currency
    ///             according to regional settings. Defaults to `"en_US"`.
    ///
    /// - Returns: A `String` representing the value formatted as a currency with the specified
    ///            symbol and locale. If formatting fails, it returns a fallback string in the
    ///            format `"\(symbol)\(self)"`.
    ///
    /// - Example:
    /// ```
    /// let price = 1234.56
    /// print(price.currencyFormatted())                     // "$1,234.56"
    /// print(price.currencyFormatted(symbol: "€"))          // "€1,234.56"
    /// print(price.currencyFormatted(locale: "fr_FR"))      // "$1 234,56"
    /// print(price.currencyFormatted(symbol: "¥", locale: "ja_JP")) // "¥1,234.56"
    /// ```
    func currencyFormatted(symbol: String = "$", locale: String = "en_US") -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = symbol
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.locale = Locale(identifier: locale)
        
        return formatter.string(from: NSNumber(value: self)) ?? "\(symbol)\(self)"
    }
}
