//
//  NumberStepper.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 19/03/25.
//

import SwiftUI

struct NumberStepper: View {
    @Binding var value: Int
    var raise: Int
    
    var body: some View {
        HStack() {
            Button{
                decrementValue()
            } label: {
                Circle()
                    .stroke(Color(UIColor.systemGray4), lineWidth: 1)
                    .frame(width: 28, height: 28)
                    .background(
                        Circle()
                            .fill(.orange)
                    )
                    .overlay{
                        Image(systemName: "minus")
                            .frame(width: 17, height: 17)
                            .foregroundStyle(.black)
                            .padding()
                    }
                
            }
            
            Text("\(value)")
                .frame(minWidth: 80, idealWidth: 168)
                .padding(.horizontal, 20)
            
            Button {
                incrementValue()
            } label: {
                Circle()
                    .stroke(Color(UIColor.systemGray4), lineWidth: 1)
                    .frame(width: 28, height: 28)
                    .background(
                        Circle()
                            .fill(.orange)
                    )
                    .overlay{
                        Image(systemName: "plus")
                            .frame(width: 17, height: 17)
                            .foregroundStyle(.black)
                            .padding()
                    }
            }
        }
        .frame(minWidth: 168)
    }
    
    private func incrementValue() {
        value += raise
    }

    private func decrementValue() {
        value -= raise
    }
}

#Preview {
    @Previewable @State var value: Int = 10
    let raise = 25
    
    NumberStepper(value: $value, raise: raise)
        .padding()
}
