//
//  PlayStoryViewModel.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 20/10/24.
//

import Foundation

class PlayStoryViewModel: ObservableObject {
    @Published var story: StoryEntity
    @Published var selectedPage: PageEntity?
    @Published var currentPageNumber: Int
    
    init(story: StoryEntity) {
        self.story = story
        self.currentPageNumber = 0
        if let firstPage = story.pages.first {
            selectedPage = firstPage
            
        }
    }
    
    public func continueToPreviousPage() {
        guard currentPageNumber > 0 else {
            return
        }
        currentPageNumber -= 1
        selectedPage = self.story.pages[currentPageNumber]
        
    }
    
    public func continueToNextPage() {
        guard currentPageNumber < story.pages.count-1 else {
            return
        }
        currentPageNumber += 1
        selectedPage = self.story.pages[currentPageNumber]
    }
}
