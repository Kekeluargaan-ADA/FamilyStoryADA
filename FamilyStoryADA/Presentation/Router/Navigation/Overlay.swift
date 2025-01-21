//
//  Overlay.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 20/01/25.
//

import SwiftUI

enum Overlay {
    case paraphrase(widthRatio: CGFloat, heightRatio: CGFloat)
    case uploadPhoto(widthRatio: CGFloat, heightRatio: CGFloat)
    case editCover(story: Binding<StoryEntity>, imageOptionPath: [String], widthRatio: CGFloat, heightRatio: CGFloat)
    case pagePreview(widthRatio: CGFloat, heightRatio: CGFloat)
    case imageInput(widthRatio: CGFloat, heightRatio: CGFloat)
    case miniGame(widthRatio: CGFloat, heightRatio: CGFloat)
    case handTapOverlay(widthRatio: CGFloat, heightRatio: CGFloat)
}

extension Overlay: Identifiable {
    var id: Self { return self }
}

extension Overlay: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
}

extension Overlay: Equatable {
    static func == (lhs: Overlay, rhs: Overlay) -> Bool {
        switch (lhs, rhs) {
        case (.paraphrase, .paraphrase),
            (.uploadPhoto, .uploadPhoto),
            (.editCover, .editCover),
            (.pagePreview, .pagePreview),
            (.imageInput, .imageInput),
            (.miniGame, .miniGame),
            (.handTapOverlay, .handTapOverlay):
            return true
        default:
            return false
        }
    }
}
