//
//  GetWatchlists.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 18/03/25.
//

import Foundation

protocol GetWatchlists {
    func execute(stocks: [Stock]) -> [Stock]
}

struct GetWatchlistsImpl: GetWatchlists {
    let watchlistRepo: WatchlistRepository

    func execute(stocks: [Stock]) -> [Stock] {
        let watchlistResult = watchlistRepo.fetchAll()
        
        switch watchlistResult {
        case .success(let watchlists):
            let watchlistNames = watchlists.map { $0.watchlistName }
            
            return stocks
                .filter { watchlistNames.contains($0.symbol) }
                .map { stock in // To attach stock description from enum because SampleData.JSON doesn't provide
                    var modifiedStock = stock
                    modifiedStock.description = StockDescription(rawValue: stock.symbol)?.value
                    return modifiedStock
                }
            
        case .failure(let error):
            debugPrint("Error fetching watchlists: \(error)")
            return []
        }
    }
}

