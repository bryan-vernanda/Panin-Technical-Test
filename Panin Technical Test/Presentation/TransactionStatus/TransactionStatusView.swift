//
//  TransactionStatusView.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 19/03/25.
//

import SwiftUI

struct TransactionStatusView: View {
    let router: any AppRouterProtocol
    
    @ObservedObject var viewModel: BuyStockViewModel
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            VStack {
                ZStack(alignment: .center) {
                    Circle()
                        .fill(Color(UIColor.green.withAlphaComponent(0.4)))
                        .frame(width: 250, height: 250)
                        .scaleEffect(isAnimating ? 1.5 : 1.0)
                        .opacity(isAnimating ? 0.0 : 1.0)
                        .animation(
                            Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: false),
                            value: isAnimating
                        )
                    
                    ZStack(alignment: .center) {
                        Circle()
                            .fill(.green)
                            .frame(width: 250, height: 250)
                        Image(systemName: "checkmark")
                            .resizable()
                            .foregroundStyle(.white)
                            .frame(width: 100, height: 100)
                    }
                }
                .onAppear {
                    isAnimating = true
                }
                
                VStack(spacing: 8) {
                    Text("Transaction Success!")
                        .font(.title)
                        .bold()
                    Text("\(viewModel.stockBuyLot) lot of \(viewModel.stock.symbol) at price \(viewModel.stock.price) placed to buy")
                }
                .padding(.top, 50)
            }
            .padding(.bottom, 50)
            
            DefaultActionButton(title: "Back to Market") {
                router.popToRoot()
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}

#Preview {
    @Previewable @StateObject var appRouter = AppRouter()
    @Previewable @State var startScreen: Screen = .transactionStatus(viewModel:
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
    
    NavigationStack(path: $appRouter.path) {
        appRouter.build(startScreen)
            .navigationDestination(for: Screen.self) { screen in
                appRouter.build(screen)
            }
    }
}
