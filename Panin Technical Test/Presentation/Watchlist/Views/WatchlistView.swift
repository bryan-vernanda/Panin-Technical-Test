//
//  WatchlistView.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 17/03/25.
//

import SwiftUI

struct WatchlistView: View {
    let router: any AppRouterProtocol
    @StateObject var viewModel = WatchlistViewModel()
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Text("Watchlist")
                    Image(systemName: "text.page.badge.magnifyingglass")
                    
                    Spacer()
                    
                    Button {
                        viewModel.isPresented = true
                    } label: {
                        Image(systemName: "plus")
                            .tint(.primary)
                    }
                }
                .font(.title)
                .fontWeight(.bold)
            }
            .padding(.bottom, 16)
            .padding(.top, 16)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            WatchlistStockListView(
                router: router,
                viewModel: viewModel
            )
            .frame(maxHeight: .infinity, alignment: .center)
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .sheet(isPresented: $viewModel.isPresented){
            WatchlistUnselectedStocksView(viewModel: viewModel)
                .presentationDetents([.medium, .large], selection: .constant(.large))
                .presentationContentInteraction(.resizes)
                .presentationContentInteraction(.scrolls)
                .presentationDragIndicator(.visible)
                .scrollIndicators(.hidden)
        }
        .onAppear {
            Task {
                await viewModel.loadWatchlist()
                await viewModel.loadUnselectedStocks()
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
