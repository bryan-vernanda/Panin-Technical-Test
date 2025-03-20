//
//  LocalWatchlistRepository.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 17/03/25.
//

import Foundation
import SwiftData

struct LocalWatchlistRepository: WatchlistRepository {
    let modelContext: ModelContext?
    
    func fetchAll() -> Result<[WatchlistSchema], Error> {
        guard let context = modelContext else {
            return .failure(NSError(domain: "ModelContextError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Model context is nil"]))
        }
        
        do {
            let descriptor = FetchDescriptor<WatchlistSchema>()
            let result = try context.fetch(descriptor)
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
    
    func fetch(watchlistName name: String) -> Result<WatchlistSchema?, Error> {
        guard let context = modelContext else {
            return .failure(NSError(domain: "ModelContextError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Model context is nil"]))
        }

        do {
            let descriptor = FetchDescriptor<WatchlistSchema>(
                predicate: #Predicate { $0.watchlistName == name }
            )

            let result = try context.fetch(descriptor).first
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
    
    func save(_ watchlist: WatchlistSchema) throws {
        guard let context = modelContext else {
            throw NSError(domain: "ModelContextError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Model context is nil"])
        }
        
        switch fetch(watchlistName: watchlist.watchlistName) {
        case .success(let existingWatchlist):
            if existingWatchlist != nil {
                throw SwiftDataError.alreadyExists(watchlist)
            }
        case .failure(let error):
            throw error
        }

        context.insert(watchlist)
        try context.save()
    }
    
    func delete(_ watchlistName: String) throws {
        guard let context = modelContext else {
            throw NSError(domain: "ModelContextError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Model context is nil"])
        }
        
        switch fetch(watchlistName: watchlistName) {
        case .success(let watchlistSchema):
            guard let watchlist = watchlistSchema else {
                throw SwiftDataError.notFound()
            }

            context.delete(watchlist)
            try context.save()

        case .failure(let error):
            throw error
        }
    }
}
