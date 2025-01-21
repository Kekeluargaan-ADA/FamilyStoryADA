//
//  FamilyStoryADAApp.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 23/09/24.
//

import SwiftUI
import SwiftData

@main
struct FamilyStoryADAApp: App {
    @StateObject var appRouter: AppRouter = .init()
    init() {
            if !UserDefaults.standard.bool(forKey: "hasLaunchedBefore") {
                UserDefaults.standard.set(true, forKey: "customizationTutorial")
                UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
                UserDefaults.standard.set(UserIDHelper().generateUserID(), forKey: "UserID")
                UserDefaults.standard.synchronize()
            }
        }
    
    var body: some Scene {
        WindowGroup {
//            StoryDashboardView()
            NavigationStack(path: $appRouter.path, root: {
                if let startScreen = appRouter.rootScreen {
                    appRouter.build(startScreen)
                        .navigationDestination(for: Screen.self, destination: { screen in
                            appRouter.build(screen)
                        })
                        .overlay(content: {
                            if let overlay = appRouter.overlay {
                                appRouter.build(overlay)
                            }
                        })
                }
            })
            .onAppear {
                appRouter.rootScreen = .storyDashboard
            }
                .statusBar(hidden: true)
                .preferredColorScheme(.light)
                .modelContainer(for: [
                    StorySwiftData.self, PageSwiftData.self, UserSwiftData.self, StoryComponentSwiftData.self, RatioSwiftData.self
                ])
        }
    }
}
