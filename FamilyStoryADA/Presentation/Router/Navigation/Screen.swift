//
//  Screen.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 20/01/25.
//

enum Screen {
    case storyDashboard
    case templateDasboard
    case customization
    case playStory
    case playStoryResult
    case miniGame
    case camera
    case crop
}

extension Screen: Identifiable {
    var id: Self { return self }
}

extension Screen: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
}

extension Screen: Equatable {
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        switch (lhs, rhs) {
        case (.storyDashboard, .storyDashboard),
            (.templateDasboard, .templateDasboard),
            (.customization, .customization),
            (.playStory, .playStory),
            (.playStoryResult, .playStoryResult),
            (.miniGame, .miniGame),
            (.camera, .camera),
            (.crop, .crop):
            return true
        default:
            return false
        }
    }
}
