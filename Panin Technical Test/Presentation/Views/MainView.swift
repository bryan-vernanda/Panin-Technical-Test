//
//  MainView.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 16/03/25.
//

import SwiftUI

struct MainView: View {
    let router: any AppRouterProtocol
    @State private var selectionTab: TabViewSelection = .stocks

    var body: some View {
        TabView(selection: $selectionTab) {
            Tab("Stock",
                systemImage: "chart.bar.xaxis.ascending",
                value: .stocks
            ) {
                StockView(router: router)
            }
            
            Tab("Watchlist",
                systemImage: "star.fill",
                value: .watchlist
            ) {
                WatchlistView(router: router)
            }
        }
        .tint(.orange)
        .onAppear {
            UITabBar.appearance().backgroundColor = .systemGray4.withAlphaComponent(0.6)
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
