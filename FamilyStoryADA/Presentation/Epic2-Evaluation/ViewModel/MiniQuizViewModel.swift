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
    @Published var droppableBox: [(DraggablePage, Bool)]
    
    init(story: StoryEntity) {
        self.story = story
        self.draggedPages = DraggablePage.fetchDraggedPage(story: story)
        self.droppableBox = DraggablePage.loadEmptyArray(storyPageCount: story.pages.count)
    }
    
    // check if story ready for checking
    public func isReadyForChecking() -> Bool {
        return !droppableBox.contains(where: {$0.0.id == nil})
    }
    
    public func checkAnswer() -> Bool {
        var isAnswerCorrect = true
        for (index, page) in droppableBox.enumerated() {
            if self.story.pages[index].pageId != page.0.id {
                draggedPages.append(page.0)
                droppableBox[index] = (.init(id: nil, picturePath: ""), false)
                isAnswerCorrect = false
            } else {
                droppableBox[index].1 = true
            }
        }
        return isAnswerCorrect
    }
    
}
