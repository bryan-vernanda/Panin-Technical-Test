//
//  MainViewModel.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 17/03/25.
//

import Foundation

@MainActor
class StockViewModel: ObservableObject {
    @Inject var getStocks: GetStocks
    
    @Published var stocks: [Stock] = []
    
    func loadStocks() async {
        let allStocks = await getStocks.execute()

        DispatchQueue.main.async {
            self.stocks = allStocks
        }
    }
}
