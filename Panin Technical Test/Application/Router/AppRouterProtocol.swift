//
//  AppRouterProtocol.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 16/03/25.
//

import SwiftUI

protocol AppRouterProtocol: ObservableObject {
    var path: NavigationPath { get set }
    var startScreen: Screen { get set }

    func push(_ screen:  Screen)
    func pop()
    func popToRoot()
}
