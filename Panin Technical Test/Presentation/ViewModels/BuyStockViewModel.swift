//
//  BuyStockViewModel.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 19/03/25.
//

import Foundation

class BuyStockViewModel: ObservableObject {
    let tradingBalance: Int
    let stockBuyFee: Int
    
    @Published var stock: Stock
    @Published var stockBuyLot: Int {
        didSet {
            validateStockBuyAmount()
        }
    }
    @Published var stockBuyAmount: Int
    @Published var isPresented: Bool
    
    init(stock: Stock) {
        self.tradingBalance = 10000000
        self.stockBuyFee = 500
        self.stock = stock
        self.stockBuyLot = 0
        self.stockBuyAmount = 0
        self.isPresented = false
    }
    
    func validateStockBuyAmount() {
        validateStockBuyLot()
        calculateStockBuyAmount()
    }
    
    private func validateStockBuyLot() {
        if stockBuyLot < 0 {
            stockBuyLot = 0
        }
    }
    
    func calculateStockBuyAmount(){
        stockBuyAmount = stock.price * stockBuyLot * 100
    }
    
    func maximumStockBuyLot() -> Int {
        let maxLot = tradingBalance / (stock.price * 100)
        return maxLot
    }
    
    func calculateStockBuyAmountPercentage() -> String {
        var percentage: Double = 0
        
        percentage = Double(stockBuyAmount) / Double(tradingBalance) * 100
        return String(format: "%.2f", percentage)
    }
    
    func determineAmountState() -> BuyCardColorState{
        if stockBuyAmount <= tradingBalance {
            return .Affordable
        } else {
            return .Exceeded
        }
    }
    
    func determineIsDisabledButtonState() -> Bool {
        if stockBuyAmount <= tradingBalance && stockBuyAmount > 0 {
            return false
        } else {
            return true
        }
    }
}
