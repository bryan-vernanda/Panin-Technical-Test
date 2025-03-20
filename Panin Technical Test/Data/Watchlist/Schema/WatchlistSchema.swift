//
//  WatchlistSchema.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 17/03/25.
//

import Foundation
import SwiftData

@Model final class WatchlistSchema {
    @Attribute(.unique) var watchlistName: String
    
    init(watchlistName: String) {
        self.watchlistName = watchlistName
    }
}
