//
//  ActionButtonColor.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 19/03/25.
//

import SwiftUI

enum DefaultActionButtonColor {
    case base
    case confirm
    case cancel
    case disabled
    
    var backgroundColor: Color {
        switch self {
        case .base:
            return .brown
        case .confirm:
            return .green
        case .cancel:
            return .red
        case .disabled:
            return .gray
        }
    }
}
