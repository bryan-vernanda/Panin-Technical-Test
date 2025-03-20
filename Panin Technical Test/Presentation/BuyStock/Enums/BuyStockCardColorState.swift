//
//  BuyStockCardColorState.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 19/03/25.
//

import SwiftUI

enum BuyStockCardColorState {
    case Affordable
    case Exceeded
    
    var textColor: Color {
        switch self {
        case .Affordable:
            return .primary
        case .Exceeded:
            return .red
        }
    }
}
