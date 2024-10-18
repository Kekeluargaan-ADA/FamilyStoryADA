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
    
    // check if story ready for checking
    public func isReadyForChecking() -> Bool {
        return !droppableBox.contains(where: {$0.id == nil})
    }
    
    public func checkAnswer() -> Bool {
        var isAnswerCorrect = true
        for (index, page) in droppableBox.enumerated() {
            if self.story.pages[index].pageId != page.id {
                draggedPages.append(page)
                droppableBox[index] = (.init(id: nil, picturePath: ""))
                isAnswerCorrect = false
            } else {
                //TODO: Implement ischecked
//                draggedPages[index].isChecked = true
            }
        }
        return isAnswerCorrect
    }
    
}
