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
        switch screen {
        case .storyDashboard:
            StoryDashboardView()
        case .templateDasboard:
            TemplateCollectionView()
        case .customization(let story):
            CustomizationView(story: story)
        case .playStory(let story):
            // TODO: Look through binding
            PlayStoryView(story: story, isMiniQuizPresented: .constant(true))
        case .playStoryResult:
            // TODO: Look through binding
            PlayStoryResultView(isMiniQuizPresented: .constant(true))
        case .miniGame(let story):
            MiniGameView(story: story)
        case .camera:
            // TODO: handle environment object
            CameraView()
        case .crop:
            // TODO: handle environemnt object
            CropImageView(croppingStyle: .landscape)
        }
    }
}

// MARK: Overlay builder
extension AppRouter {
    @ViewBuilder
    func build(_ overlay: Overlay) -> some View {
        switch overlay {
        case .paraphrase(let widthRatio, let heightRatio):
            // TODO: Resolve view model coupling for ParaphraseModal
            EmptyView()
        case .uploadPhoto(let widthRatio, let heightRatio):
            // TODO: Resolve view model coupling for UpdatePhotoModalView
            EmptyView()
        case .editCover(let story, let imageOption, let widthRatio, let heightRatio):
            EditCoverModalView(story: story, imageOptionPath: imageOption, widthRatio: widthRatio, heightRatio: heightRatio)
        case .pagePreview(let widthRatio, let heightRatio):
            // TODO: Resolve view model coupling
            PagePreviewModalView(widthRatio: widthRatio, heightRatio: heightRatio)
        case .imageInput(let widthRatio, let heightRatio):
            // TODO: Resolve coupling with view model
            EmptyView()
        case .miniGame(let widthRatio, let heightRatio):
            // TODO: Resolve coupling with view model
            MiniQuizModalView(widthRatio: widthRatio, heightRatio: heightRatio)
        case .handTapOverlay(let widthRatio, let heightRatio):
            HandTapOverlay(widthRatio: widthRatio, heightRatio: heightRatio)
        }
    }
}
