//
//  LocalStockRepository.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 16/03/25.
//

import Foundation

final class LocalStockRepository: StockRepository {
    func getStocks() async -> Result<Stocks, Error> {
        var stocks: Stocks = Stocks(stocks: [])

        do {
            stocks = try await JSONHelper.readJSONFromFile(fileName: JSONHelper.templateName, type: Stocks.self)
            return .success(stocks)
        } catch {
            return .failure(error)
        }
    }
}
