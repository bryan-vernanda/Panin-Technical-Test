//
//  StockView.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 17/03/25.
//

import SwiftUI

struct StockView: View {
    let router: any AppRouterProtocol
    @StateObject private var viewModel = StockViewModel()

    var body: some View {
        HStack {
            Text("Stock List")
            
            Image(systemName: "chart.line.text.clipboard")
        }
        .fontWeight(.bold)
        .font(.title)
        .padding(.bottom, 32)
        .padding(.top, 16)
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
        .onAppear {
            Task {
                await viewModel.loadStocks()
            }
        }
        
        ScrollView(.horizontal, showsIndicators: false) {
            VStack(alignment: .leading) {
                // Header Row
                HStack {
                    Text("STOCK").bold().frame(width: 80, alignment: .leading)
                    Text("VOL").bold().frame(width: 80, alignment: .leading)
                    Text("FRQ").bold().frame(width: 80, alignment: .leading)
                    Text("PREV").bold().frame(width: 80, alignment: .leading)
                    Text("+/-").bold().frame(width: 80, alignment: .leading)
                    Text("%").bold().frame(width: 80, alignment: .leading)
                    Text("PRICE").bold().frame(width: 80, alignment: .leading)
                }
                .padding(.bottom, 4)
                .foregroundStyle(.orange)
                
                // List of Stocks
                List {
                    ForEach(viewModel.stocks, id: \.symbol) { stock in
                        VStack {
                            HStack {
                                Text(stock.symbol)
                                    .frame(width: 80, alignment: .leading)
                                Text(stock.volume)
                                    .frame(width: 80, alignment: .leading)
                                Text(stock.frequency)
                                    .frame(width: 80, alignment: .leading)
                                Text("\(stock.previous)")
                                    .frame(width: 80, alignment: .leading)
                                Text((stock.change > 0 ? "+" : "") + "\(stock.change)")
                                    .foregroundStyle(stock.change.profitLossColor())
                                    .frame(width: 80, alignment: .leading)
                                Text(stock.percentage)
                                    .foregroundStyle(stock.change.profitLossColor())
                                    .frame(width: 80, alignment: .leading)
                                Text("\(stock.price)")
                                    .foregroundStyle(stock.change.profitLossColor())
                                    .frame(width: 80, alignment: .leading)
                            }
                            Divider()
                        }
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
            }
            .padding(.horizontal)
        }
    }
}


#Preview {
    @Previewable @StateObject var appRouter = AppRouter()
    
    NavigationStack(path: $appRouter.path) {
        appRouter.build(appRouter.startScreen)
            .navigationDestination(for: Screen.self) { screen in
                appRouter.build(screen)
            }
    }
}
