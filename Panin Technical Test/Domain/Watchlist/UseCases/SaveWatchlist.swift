//
//  SaveWatchlist.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 18/03/25.
//

import Foundation

protocol SaveWatchlist {
    func execute(watchlist: Stock) throws
}

struct SaveWatchlistImpl: SaveWatchlist {
    let watchlistRepo: WatchlistRepository

    func execute(watchlist: Stock) throws {
        let watchlistSchema = WatchlistSchema(
            watchlistName: watchlist.symbol
        )
        
        try watchlistRepo.save(watchlistSchema)
    }
}
