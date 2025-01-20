//
//  Overlay.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 20/01/25.
//

enum Overlay {
    case paraphrase
    case uploadPhoto
    case editCover
    case pagePreview
    case imageInput
    case miniGame
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
            (.miniGame, .miniGame):
            return true
        default:
            return false
        }
    }
}
