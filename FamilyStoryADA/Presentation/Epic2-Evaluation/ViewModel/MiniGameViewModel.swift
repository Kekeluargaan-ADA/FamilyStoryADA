//
//  MiniGameViewModel.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 06/11/24.
//

import Foundation

class MiniGameViewModel: Imageable, ObservableObject {
    @Published var story: StoryEntity
    
    init(story: StoryEntity) {
        self.story = story
    }
}