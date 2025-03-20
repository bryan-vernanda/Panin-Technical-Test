//
//  DefaultActionButtonSize.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 19/03/25.
//

import SwiftUI

enum DefaultActionButtonSize {
    case large
    case medium
    
    var maxWidth: CGFloat {
        switch self {
        case .large:
            return .infinity
        case .medium:
            return 170
        }
    }
    
    var verticalPadding: CGFloat {
        switch self {
        case .large:
            return 16
        case .medium:
            return 8
        }
    }
}
