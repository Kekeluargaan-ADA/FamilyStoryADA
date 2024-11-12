//
//  MiniQuizViewModel.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 18/10/24.
//

import Foundation
import UIKit

class MiniQuizViewModel: Imageable, ObservableObject {
    @Published var story: StoryEntity
    @Published var draggedPages: [DraggablePage] = []
    @Published var droppableBox: [(DraggablePage, Bool)]
    @Published var isAllCorrect: Bool = false
    @Published var isDismissed: Bool = false
    
    init(story: StoryEntity) {
        self.story = story
        self.draggedPages = DraggablePage.fetchDraggedPage(story: story)
        self.droppableBox = DraggablePage.loadEmptyArray(storyPageCount: story.pages.count - 2)
    }
    
    // check if story ready for checking
    public func isReadyForChecking() -> Bool {
        return !droppableBox.contains(where: {$0.0.id == nil})
    }
    
    public func checkAnswer() -> Bool {
        var isAnswerCorrect = true
        for (index, page) in droppableBox.enumerated() {
            if self.story.pages[index+1].pageId != page.0.id { // +1 for skipping opening
                draggedPages.append(page.0)
                droppableBox[index] = (.init(id: nil, order: 0, picturePath: ""), false) // TODO: Fix
                isAnswerCorrect = false
            } else {
                droppableBox[index].1 = true
            }
        }
        return isAnswerCorrect
    }
    
    public func resetQuiz() {
        self.draggedPages = DraggablePage.fetchDraggedPage(story: story)
        self.droppableBox = DraggablePage.loadEmptyArray(storyPageCount: story.pages.count - 2)
        self.isAllCorrect = false
    }
    
    public func displayImage(fileName: String) -> UIImage {
        var image = UIImage()
        guard fileName != "" else { return image }
        if let imageAppStorage = loadImageFromDiskWith(fileName: fileName) {
            image = imageAppStorage
        } else {
            image = UIImage(imageLiteralResourceName: fileName)
        }
        
        return image
    }
}
