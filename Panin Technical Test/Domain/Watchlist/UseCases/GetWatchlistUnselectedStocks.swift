//
//  GetWatchlistUnselectedStocks.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 18/03/25.
//

import Foundation

protocol GetWatchlistUnselectedStocks {
    func execute(allStocks: [Stock], watchlistStocks: [Stock]) -> [Stock]
}

struct GetWatchlistUnselectedStocksImpl: GetWatchlistUnselectedStocks {
    func execute(allStocks: [Stock], watchlistStocks: [Stock]) -> [Stock] {
        let watchlistSymbols = Set(watchlistStocks.map { $0.symbol })
        return allStocks
                .filter { !watchlistSymbols.contains($0.symbol) }
                .map { stock in // To attach stock description from enum because SampleData.JSON doesn't provide
                    var modifiedStock = stock
                    modifiedStock.description = StockDescription(rawValue: stock.symbol)?.value
                    return modifiedStock
                }
    }
}
