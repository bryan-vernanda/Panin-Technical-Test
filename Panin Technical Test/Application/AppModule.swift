//
//  AppModule.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 16/03/25.
//

struct AppModule {
    static func inject(){
        
        // MARK: - Repository
        let stockRepository: StockRepository = LocalStockRepository()
        
        // MARK: - USE Case
        
        // Stocks
        @Provider var getStocks: GetStocks = GetStocksImpl(stockRepo: stockRepository)
    }
}
