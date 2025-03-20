//
//  BuyStockConfirmTransactionView.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 19/03/25.
//

import SwiftUI

struct BuyStockConfirmTransactionView: View {
    let viewModel: BuyStockViewModel
    let cancelAction: () -> Void
    let confirmAction: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7).ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 24) {
                Text("Preview Buy Order")
                    .foregroundStyle(.black)
                    .padding(.top, 16)
                
                VStack(alignment: .leading, spacing: 12){
                    BuyStockConfirmRow(title: "Stock", value: viewModel.stock.symbol)
                    BuyStockConfirmRow(title: "Price", value: "\(PriceFormatter.formatIntToIDR(viewModel.stock.price))")
                    BuyStockConfirmRow(title: "Fee", value: "\(PriceFormatter.formatIntToIDR(viewModel.stockBuyFee))")
                    BuyStockConfirmRow(title: "Lot", value: "\(viewModel.stockBuyLot)")
                    BuyStockConfirmRow(title: "Amount", value: "\(PriceFormatter.formatIntToIDR(viewModel.stockBuyAmount))")
                }
                .padding(.horizontal)
                .foregroundStyle(.black)
                
                HStack{
                    DefaultActionButton(size: .medium, buttonColor: .cancel, title: "Cancel") {
                        cancelAction()
                    }
                    DefaultActionButton(size: .medium, buttonColor: .confirm, title: "Confirm") {
                        confirmAction()
                    }
                }
            }
            .font(.callout)
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.white, lineWidth: 1)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.white)
                    )
            )
            .padding()
        }
    }
}

#Preview {
    BuyStockConfirmTransactionView(
        viewModel: BuyStockViewModel(stock:
            Stock(
                symbol: "BMRI",
                volume: "1.59M",
                frequency: "18.14K",
                previous: 4940,
                change: 85,
                percentage: "+1.72%",
                price: 5025,
                description: "Bank Mandiri Tbk"
            )
        ),
        cancelAction: {
            debugPrint("Cancel button pressed")
        },
        confirmAction: {
            debugPrint("Confirm button pressed")
        }
    )
}
