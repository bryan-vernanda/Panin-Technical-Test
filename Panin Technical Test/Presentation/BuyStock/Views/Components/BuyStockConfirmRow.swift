//
//  BuyStockConfirmationRow.swift
//  Panin Technical Test
//
//  Created by Bryan Vernanda on 20/03/25.
//

import SwiftUI

struct BuyStockConfirmRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 24) {
            Text(title)
                .frame(width: 120, alignment: .topLeading)
            Text(value)
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}

#Preview {
    BuyStockConfirmRow(title: "Stock", value: "BBCA")
}
