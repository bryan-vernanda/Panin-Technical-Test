//
//  FetchStocks.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 16/03/25.
//

import Foundation

protocol GetStocks {
    func execute() async -> [Stock]
}

struct GetStocksImpl: GetStocks {
    let stockRepo: StockRepository

    func execute() async -> [Stock] {
        let result = await stockRepo.getStocks()
        
        switch result {
        case .success(let stocks):
            return stocks.stocks
        case .failure(let error):
            debugPrint("Error fetching stocks from JSON: \(error)")
            return []
        }
    }
}
