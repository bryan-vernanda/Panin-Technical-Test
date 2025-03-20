//
//  SwiftDataContextManager.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 17/03/25.
//

import Foundation
import SwiftData

public class SwiftDataContextManager {
    public static var shared = SwiftDataContextManager()
    var container: ModelContainer?
    var context: ModelContext?
    
    init() {
        do {
            container = try ModelContainer(
                for: setupSchema()
            )
            
            if let container {
                context = ModelContext(container)
                intializeSwiftData()
            }
        } catch {
            debugPrint("Error initializing database container: ", error)
        }
    }
    
    private func intializeSwiftData() {
        prepopulateSystemData()
    }
    
    private func setupSchema() -> Schema {
        return Schema([
            WatchlistSchema.self
        ])
    }
}

// CRUD Method
private extension SwiftDataContextManager {
    // CREATE
    func saveWatchlistData(watchlistSchema: WatchlistSchema) {
        if let context{
            context.insert(watchlistSchema)
        }
    }
    
    // READ
    func fetchWatchlistData() -> Int {
        if let context {
            do {
                let descriptor = FetchDescriptor<WatchlistSchema>()
                let watchlistSchema = try context.fetchCount(descriptor)
                return watchlistSchema
            }
            catch {
                fatalError("Error Fetch Data: \(error)")
            }
        }
        return 0
    }
}

// Prepopulate Data
private extension SwiftDataContextManager {
    func prepopulateSystemData() {
        let watchlistSchemaData = fetchWatchlistData()
        
        if watchlistSchemaData <= 0 {
            let result = getWatchlistData()
            for data in result {
                saveWatchlistData(watchlistSchema: data)
            }
        }
    }
    
    func getWatchlistData() -> [WatchlistSchema] {
        return []
    }
}
