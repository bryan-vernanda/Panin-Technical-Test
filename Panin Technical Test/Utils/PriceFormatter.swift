//
//  PriceFormatter.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 19/03/25.
//

import Foundation

struct PriceFormatter {
    static func formatIntToIDR(_ num: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = "IDR"
        numberFormatter.currencySymbol = "Rp "
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.locale = Locale(identifier: "id_ID")
        
        if let formattedAmount = numberFormatter.string(from: NSNumber(value: num)) {
            return formattedAmount
        } else {
            return "Rp \(num)"
        }
    }
}
