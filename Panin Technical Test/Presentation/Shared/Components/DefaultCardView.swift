//
//  DefaultStockCardView.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 18/03/25.
//

import SwiftUI

struct DefaultCardView: View {
    let stock: Stock
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text(stock.symbol)
                    .font(.title2)
                Text(stock.description ?? "")
                    .font(.callout)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(PriceFormatter.formatIntToIDR(stock.price))")
                HStack(spacing: 2) {
                    Image(systemName: (stock.change > 0) ? "arrow.up" : "arrow.down")
                    Text("\(abs(stock.change))")
                    Text("(\(stock.percentage.dropFirst()))")
                }
                .foregroundStyle(stock.change.profitLossColor())
            }
            .font(.callout)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 90)
        .padding(.horizontal)
    }
}

#Preview {
    DefaultCardView(stock:
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
    )
}
