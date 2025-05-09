//
//  BuyStockCardView.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 19/03/25.
//

import SwiftUI

struct BuyStockCardView: View {
    // Constant
    let MIN_LOT = 0
    let RAISE_LOT = 1
    
    @ObservedObject var viewModel: BuyStockViewModel
    
    var body: some View {
        let amountState = viewModel.determineAmountState()
        
        VStack(spacing: 16) {
            HStack {
                Text("Trading Balance")
                
                Spacer()
                
                Text("\(PriceFormatter.formatIntToIDR(viewModel.tradingBalance))")
            }
            
            HStack {
                BuyStockCustomSlider(value: $viewModel.stockBuyLot, minimum: MIN_LOT, maximum: viewModel.maximumStockBuyLot())
                    .padding(.trailing, 12)
                
                Spacer()
                
                Text("\(viewModel.calculateStockBuyAmountPercentage()) %")
                    .foregroundStyle(amountState.textColor)
                    .frame(maxWidth: 80, alignment: .trailing)
            }
            
            HStack{
                Text("Amount")
                
                Spacer()
                
                Text("\(PriceFormatter.formatIntToIDR(viewModel.stockBuyAmount))")
                    .foregroundStyle(amountState.textColor)
            }
            
            HStack{
                Text("Price")
                
                Spacer()
                
                Text("\(PriceFormatter.formatIntToIDR(viewModel.stock.price))")
            }
            
            HStack{
                Text("Lot")
                
                Spacer()
                
                BuyStockNumberStepper(
                    value: $viewModel.stockBuyLot,
                    raise: RAISE_LOT
                )
            }
        }
        .font(.callout)
        .padding()
    }
}

#Preview {
    VStack {
        BuyStockCardView(viewModel:
            BuyStockViewModel(stock:
                Stock(
                    symbol: "ADRO",
                    volume: "185.74K",
                    frequency: "6.18K",
                    previous: 2240,
                    change: -20,
                    percentage: "-0.89%",
                    price: 2220,
                    description: "Adaro Energy Indonesia Tbk."
                )
            )
        )
    }
}
