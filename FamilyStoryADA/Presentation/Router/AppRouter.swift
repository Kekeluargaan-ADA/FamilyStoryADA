//
//  AppRouter.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 20/01/25.
//

import Foundation
import SwiftUI

class AppRouter: ObservableObject {
    @Published var path: NavigationPath = .init()
    @Published var rootScreen: Screen?
    @Published var overlay: Overlay?
    
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    func popScreen() {
        path.removeLast()
    }
    
    func popScreenToRoot() {
        path.removeLast(path.count)
    }
    
    func presentOverlay(_ overlay: Overlay) {
        self.overlay = overlay
    }
    
    func dismissOverlay() {
        self.overlay = nil
    }
}

// MARK: Screen builder
extension AppRouter {
    @ViewBuilder
    func build(_ screen: Screen) -> some View {
        
    }
}

// MARK: Overlay builder
extension AppRouter {
    @ViewBuilder
    func build(_ overlay: Overlay) -> some View {
        
    }
}
