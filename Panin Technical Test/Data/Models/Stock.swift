//
//  Stock.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 16/03/25.
//

import Foundation

// MARK: - Stock Model
struct Stock: Codable, Identifiable, Hashable {
    var id: String { symbol }
    let symbol: String
    let volume: String
    let frequency: String
    let previous: Int
    let change: Int
    let percentage: String
    let price: Int
    var description: String?
}
