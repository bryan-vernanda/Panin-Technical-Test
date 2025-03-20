//
//  SwiftDataError.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 17/03/25.
//

import Foundation

enum SwiftDataError: LocalizedError {
    case notFound(_ object: Any? = nil)
    case alreadyExists(_ object: Any? = nil)
    case failed(_ object: Any? = nil)
    case noData(_ object: Any? = nil)
    case genericError(error: Error)
}
