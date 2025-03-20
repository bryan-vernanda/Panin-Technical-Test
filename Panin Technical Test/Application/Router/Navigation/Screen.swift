//
//  Screen.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 16/03/25.
//

enum Screen: Identifiable, Hashable, Equatable {
    case main
    case watchlist
    case buyStock(stock: Stock)
    case transactionStatus(viewModel: BuyStockViewModel)

    var id: Self { self }
}

extension Screen {
    // Conform to Hashable
    func hash(into hasher: inout Hasher) {
        switch self {
        case .main:
            hasher.combine(self.hashValue)
        case .watchlist:
            hasher.combine(self.hashValue)
        case .buyStock:
            hasher.combine(self.hashValue)
        case .transactionStatus:
            hasher.combine(self.hashValue)
        }
    }
    
    // Conform to Equatable
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        switch (lhs, rhs) {
        case (.main, .main),
            (.watchlist, .watchlist),
            (.buyStock, .buyStock),
            (.transactionStatus, .transactionStatus):
            return true
        default:
            return false
        }
    }
}


