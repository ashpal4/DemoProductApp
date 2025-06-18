//
//  Double+Extensions.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 16/06/25.
//

import Foundation

extension Double {
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
