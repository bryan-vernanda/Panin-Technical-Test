//
//  WatchlistUnselectedStocksView.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 18/03/25.
//

import SwiftUI

struct WatchlistUnselectedStocksView: View {
    @ObservedObject var viewModel: WatchlistViewModel
    @State private var multiSelection = Set<String>()
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        if viewModel.unselectedStocks.isEmpty {
            VStack {
                Image(systemName: "text.page.slash")
                    .resizable()
                    .frame(width: 50, height: 50)
                Text("No stocks to be added")
            }
            .font(.title)
            .opacity(0.5)
        } else {
            NavigationStack {
                ZStack {
                    VStack {
                        List(selection: $multiSelection) {
                            ForEach(viewModel.unselectedStocks, id: \.symbol) { stock in
                                VStack(spacing: 0) {
                                    DefaultCardView(stock: stock)
                                    Divider()
                                        .padding(.horizontal)
                                }
                                .listRowInsets(EdgeInsets())
                                .listRowSeparator(.hidden)
                            }
                        }
                        .padding(.bottom, 100)
                        .listStyle(.plain)
                        .scrollIndicators(.hidden)
                        .environment(\.editMode, .constant(.active))
                    }
                    
                    // Floating Button
                    VStack {
                        Spacer()
                        
                        DefaultActionButton(title: "Add to Watchlist (\(multiSelection.count))") {
                            Task {
                                let selectedStocks = viewModel.unselectedStocks.filter { multiSelection.contains($0.symbol) }
                                
                                await viewModel.saveToWatchlist(stocks: selectedStocks)
                                await viewModel.loadWatchlist()
                                await viewModel.loadUnselectedStocks()
                                
                                viewModel.isPresented = false
                            }
                        }
                        .background(Color(UIColor.systemGray4).opacity(0.6))
                    }
                }
                .navigationTitle("Stock List")
            }
        }
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

