//
//  WatchlistViewModel.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 18/03/25.
//

import Foundation

@MainActor
class WatchlistViewModel: ObservableObject {
    @Inject var getStocks: GetStocks
    @Inject var getWatchlists: GetWatchlists
    @Inject var getWatchlistUnselectedStocks: GetWatchlistUnselectedStocks
    @Inject var saveWatchlist: SaveWatchlist
    @Inject var deleteWatchlist: DeleteWatchlist
    
    @Published var watchlists: [Stock] = []
    @Published var unselectedStocks: [Stock] = []
    @Published var isPresented: Bool = false
    
    func loadWatchlist() async {
        let allStocks = await getStocks.execute()
        let watchlists = getWatchlists.execute(stocks: allStocks)
        
        DispatchQueue.main.async {
            self.watchlists = watchlists
        }
    }

    func loadUnselectedStocks() async {
        let allStocks = await getStocks.execute()
        let unselectedStocks = getWatchlistUnselectedStocks.execute(allStocks: allStocks, watchlistStocks: self.watchlists)

        DispatchQueue.main.async {
            self.unselectedStocks = unselectedStocks
        }
    }
    
    func saveToWatchlist(stocks: [Stock]) async {
        for stock in stocks {
            do {
                try saveWatchlist.execute(watchlist: stock)
            } catch {
                debugPrint("Error saving stock: \(stock.symbol), Error: \(error)")
            }
        }
    }
    
    func deleteWatchlist(watchlist: Stock) async {
        do {
            try deleteWatchlist.execute(watchlist: watchlist)
        } catch {
            debugPrint("Error deleting stock: \(watchlist.symbol), Error: \(error)")
        }
    }
}
