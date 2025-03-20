//
//  StockRepository.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 16/03/25.
//

import Foundation

protocol StockRepository {
    func getStocks() async -> Result<Stocks, Error>
}
