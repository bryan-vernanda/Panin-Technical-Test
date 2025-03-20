//
//  WatchlistStockListView.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 18/03/25.
//

import SwiftUI

struct WatchlistStockListView: View {
    let router: any AppRouterProtocol
    @ObservedObject var viewModel: WatchlistViewModel
    
    var body: some View {
        if viewModel.watchlists.isEmpty {
            VStack {
                Image(systemName: "text.page.slash")
                    .resizable()
                    .frame(width: 50, height: 50)
                Text("No watchlist yet")
            }
            .font(.title)
            .opacity(0.5)
        } else {
            List {
                ForEach(viewModel.watchlists, id: \.symbol) { watchlist in
                    VStack(spacing: 0) {
                        StockCardView(stock: watchlist)
                            .swipeActions(edge: .leading) {
                                buyStock(watchlist: watchlist)
                            }
                            .swipeActions(edge: .trailing) {
                                deleteStock(watchlist: watchlist)
                            }
                        
                        Divider()
                            .padding(.horizontal)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    private func buyStock(watchlist: Stock) -> some View {
        Button {
            router.push(
                .buyStock(stock: watchlist)
            )
        } label: {
            VStack {
                Image(systemName: "cart.fill")
                Text("Buy")
            }
        }
        .tint(.green)
    }
    
    private func deleteStock(watchlist: Stock) -> some View {
        Button(role: .destructive) {
            Task {
                await viewModel.deleteWatchlist(watchlist: watchlist)
                await viewModel.loadWatchlist()
                await viewModel.loadUnselectedStocks()
            }
        } label: {
            VStack {
                Image(systemName: "trash.fill")
                Text("Delete")
            }
        }
        .tint(.red)
    }
}

#Preview {
    @Previewable @StateObject var appRouter = AppRouter()
    @Previewable @State var startScreen: Screen = .watchlist
    
    NavigationStack(path: $appRouter.path) {
        appRouter.build(startScreen)
            .navigationDestination(for: Screen.self) { screen in
                appRouter.build(screen)
            }
    }
}

