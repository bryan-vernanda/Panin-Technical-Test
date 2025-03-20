//
//  NavigationBar.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 19/03/25.
//

import SwiftUI

struct BuyStockNavigationBar: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Text(title)
                .font(.title3)
            
            Button {
                action()
            } label: {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
            }
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

#Preview {
    BuyStockNavigationBar(
        title: "Hello, World!",
        action: {
            debugPrint("Navigation bar pressed")
        }
    )
    .frame(maxHeight: .infinity, alignment: .top)
}
