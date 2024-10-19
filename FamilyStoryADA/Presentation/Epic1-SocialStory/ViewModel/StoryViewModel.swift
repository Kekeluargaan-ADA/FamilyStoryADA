//
//  StoryViewModel.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 13/10/24.
//

import Foundation
import SwiftData

enum SortOption: String {
    case newest = "Terbaru"
    case oldest = "Terlama"
}

class StoryViewModel: ObservableObject {
    @Published var stories: [StoryEntity] = []
    @Published var displayedStory: [StoryEntity]
    
    @Published var selectedOption: SortOption = .newest
    @Published var isEditCoverSheetOpened: Bool = false
    @Published var currentlyEditedStory: StoryEntity?
    
    private let storyUsecase: StoryUsecase
    
    @MainActor
    init() {
        self.storyUsecase = ImplementedStoryUsecase()
        self.stories = [StoryEntity]()
        self.displayedStory = [StoryEntity]()
        
        fetchStories()
    }
    
    // fetch story
    public func fetchStories() {
        self.stories = storyUsecase.fetchStories()
        updateStoryDisplay()
    }
    
    // update displayedStory
    public func updateStoryDisplay() {
        displayedStory = [StoryEntity]()
        displayedStory.append(StoryEntity(storyId: UUID(),
                                          storyName: "",
                                          storyCoverImagePath: "",
                                          storyLastRead: Date(),
                                          templateId: UUID(),
                                          templateCategory: "",
                                          pages: []
                                         )
        )
        displayedStory.append(contentsOf: stories)
        objectWillChange.send()
    }
    
    func addNewStory(templateId: UUID) {
        let _ = storyUsecase.addNewStory(templateId: templateId)
        
        fetchStories()
    }
    
    func deleteStory(storyId: UUID) {
        // delete from swiftdata
        let result = storyUsecase.removeStory(storyId: storyId)
        
        guard result == true else {
            return
        }
        
        //re-fetch story
        fetchStories()
    }
    
    func updateStory(story: StoryEntity) {
        _ = storyUsecase.updateStory(story: story)
    }
    
//    //debug func
//    func printStories() {
//        for story in stories {
//            print(story.storyId)
//            print(story.storyName)
//            print(story.storyCoverImagePath)
//        }
//    }
//    
//    func printDisplayed() {
//        print("-------------------------")
//        print("DISPLAYED")
//        for story in displayedStory {
//            print(story.storyId)
//            print(story.storyName)
//            print(story.storyCoverImagePath)
//        }
//    }
}
