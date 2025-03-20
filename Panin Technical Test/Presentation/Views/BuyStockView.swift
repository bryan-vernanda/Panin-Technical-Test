//
//  BuyStockView.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 19/03/25.
//

import SwiftUI

struct BuyStockView: View {
    let router: any AppRouterProtocol
    let stock: Stock
    @StateObject private var viewModel: BuyStockViewModel
    
    init(router: any AppRouterProtocol, stock: Stock) {
        self.router = router
        self.stock = stock
        _viewModel = StateObject(wrappedValue: BuyStockViewModel(stock: stock))
    }
    
    var body: some View {
        VStack {
            NavigationBar(title: "Buy \(stock.symbol)") {
                router.pop()
            }
            
            Divider()
            
            StockCardView(stock: stock)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(UIColor.systemGray4).opacity(1), lineWidth: 2)
                )
                .padding(.horizontal)
                .padding(.top, 16)
            
            BuyCardView(viewModel: viewModel)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(UIColor.systemGray4).opacity(1), lineWidth: 2)
                )
                .padding(.horizontal)
                .padding(.top, 16)
            
            Spacer()
            
            ActionButton(
                buttonColor: (viewModel.stockBuyLot != 0) ? .base : .disabled,
                title: "Buy"
            ) {
                viewModel.isPresented = true
            }
        }
        .overlay {
            if viewModel.isPresented {
                ConfirmTransactionView(
                    viewModel: viewModel,
                    cancelAction: {
                        viewModel.isPresented = false
                    },
                    confirmAction: {
                        router.push(
                            .transactionStatus(viewModel: viewModel)
                        )
                    }
                )
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var appRouter = AppRouter()
    @Previewable @State var startScreen: Screen = .buyStock(stock: Stock(
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
    
    NavigationStack(path: $appRouter.path) {
        appRouter.build(startScreen)
            .navigationDestination(for: Screen.self) { screen in
                appRouter.build(screen)
            }
    }
}
