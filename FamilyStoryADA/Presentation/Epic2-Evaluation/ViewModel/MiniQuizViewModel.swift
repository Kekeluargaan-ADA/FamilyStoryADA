//
//  MiniQuizViewModel.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 18/10/24.
//

import Foundation

class MiniQuizViewModel: ObservableObject {
    @Published var story: StoryEntity
    @Published var draggedPages: [DraggablePage] = []
    @Published var droppableBox: [DraggablePage]
    
    init(story: StoryEntity) {
        self.story = story
        self.draggedPages = DraggablePage.fetchDraggedPage(story: story)
        self.droppableBox = DraggablePage.loadEmptyArray(storyPageCount: story.pages.count)
    }
    
    
    
}
