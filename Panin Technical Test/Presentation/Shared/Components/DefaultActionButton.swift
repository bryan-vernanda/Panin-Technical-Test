//
//  DefaultActionButton.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 19/03/25.
//

import SwiftUI

struct DefaultActionButton: View {
    var size: DefaultActionButtonSize = .large
    var buttonColor: DefaultActionButtonColor = .base
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        VStack {
            Button {
                action()
            } label: {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: size.maxWidth)
                    .padding(.vertical, size.verticalPadding)
                    .background(buttonColor.backgroundColor)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.bottom)
            }
        }
        .padding(.vertical, size.verticalPadding)
        .frame(maxWidth: .infinity)
        .disabled(buttonColor == .disabled)
    }
}

#Preview {
    DefaultActionButton(
        title: "Press",
        action: {
            debugPrint("Action button pressed")
        }
    )
}
