//
//  WatchlistRepository.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 17/03/25.
//

protocol WatchlistRepository {
    func fetchAll() -> Result<[WatchlistSchema], Error>
    func fetch(watchlistName: String) -> Result<WatchlistSchema?, Error>
    func save(_ watchlist: WatchlistSchema) throws
    func delete(_ watchlistName: String) throws
}
