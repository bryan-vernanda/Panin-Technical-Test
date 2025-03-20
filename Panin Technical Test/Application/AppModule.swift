//
//  AppModule.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 16/03/25.
//

struct AppModule {
    static func inject(){
        
        // MARK: - Repository
        let modelContext = SwiftDataContextManager.shared.context
        let stockRepository: StockRepository = LocalStockRepository()
        let watchlistRepository: WatchlistRepository = LocalWatchlistRepository(modelContext: modelContext)
        
        
        // MARK: - USE Case
        
        // Stocks
        @Provider var getStocks: GetStocks = GetStocksImpl(stockRepo: stockRepository)
        
        // Watchlists
        @Provider var getWatchlists: GetWatchlists = GetWatchlistsImpl(watchlistRepo: watchlistRepository)
        @Provider var getWatchlistUnselectedStocks: GetWatchlistUnselectedStocks = GetWatchlistUnselectedStocksImpl()
        @Provider var saveWatchlist: SaveWatchlist = SaveWatchlistImpl(watchlistRepo: watchlistRepository)
        @Provider var deleteWatchlist: DeleteWatchlist = DeleteWatchlistImpl(watchlistRepo: watchlistRepository)
    }
}
