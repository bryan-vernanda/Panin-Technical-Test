//
//  Panin_Technical_TestApp.swift
//  Panin Technical Test
//
//  Created by Bryan Vernanda on 16/03/25.
//

import SwiftUI

@main
struct Panin_Technical_TestApp: App {
    @StateObject private var appRouter = AppRouter()
    
    init(){
        AppModule.inject()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appRouter.path) {
                appRouter.build(appRouter.startScreen)
                    .navigationDestination(for: Screen.self) { screen in
                        appRouter.build(screen)
                    }
            }
        }
    }
}
