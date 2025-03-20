//
//  MockSwiftDataContextManager.swift
//  Panin Technical Test
//
//  Created by Bryan Vernanda on 20/03/25.
//

import Foundation
import SwiftData
@testable import Panin_Technical_Test

final class MockSwiftDataContextManager {
    var container: ModelContainer?
    var context: ModelContext?
    
    init() {
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
            container = try ModelContainer(for: WatchlistSchema.self, configurations: configuration)
            if let container {
                context = ModelContext(container)
            }
        } catch {
            debugPrint("Error initializing database container:", error)
        }
    }
}
