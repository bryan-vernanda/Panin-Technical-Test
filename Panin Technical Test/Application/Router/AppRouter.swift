//
//  AppRouter.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 16/03/25.
//

import SwiftUI

class AppRouter: AppRouterProtocol, ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    @Published var startScreen: Screen = .main
    
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    // MARK: - Presentation Style Providers
    @ViewBuilder
    func build(_ screen: Screen) -> some View {
        switch screen {
        case .main:
            ZStack {
                MainView(router: self)
            }
            .navigationBarBackButtonHidden()
            
        case .watchlist:
            ZStack {
                WatchlistView(router: self)
            }
            .navigationBarBackButtonHidden()
        
        case .buyStock(let stock):
            ZStack {
                BuyStockView(router: self, stock: stock)
            }
            .navigationBarBackButtonHidden()
        case .transactionStatus(let buyStockViewModel):
            ZStack {
                TransactionStatusView(router: self, viewModel: buyStockViewModel)
            }
            .navigationBarBackButtonHidden()
        }
    }
}
