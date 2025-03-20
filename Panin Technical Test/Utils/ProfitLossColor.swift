//
//  FuncProfitLossColor.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 18/03/25.
//

import SwiftUI

extension Int {
    func profitLossColor() -> Color {
        switch self {
            case let x where x > 0:
                return .green
            default:
                return .red
        }
    }
}
