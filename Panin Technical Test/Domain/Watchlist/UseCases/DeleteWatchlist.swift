//
//  DeleteWatchlist.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 18/03/25.
//

import Foundation

protocol DeleteWatchlist {
    func execute(watchlist: Stock) throws
}

struct DeleteWatchlistImpl: DeleteWatchlist {
    let watchlistRepo: WatchlistRepository

    func execute(watchlist: Stock) throws {
        try watchlistRepo.delete(watchlist.symbol)
    }
}

