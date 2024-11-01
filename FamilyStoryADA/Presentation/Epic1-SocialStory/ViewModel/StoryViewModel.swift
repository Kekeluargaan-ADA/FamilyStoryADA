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
    @Published var searchText: String = ""
    @Published var selectedOption: SortOption = .newest
    @Published var isEditCoverSheetOpened: Bool = false
    @Published var currentlyEditedStory: StoryEntity?
    
    private let storyUsecase: StoryUsecase
    private let templateUsecase: TemplateUsecase
    
    @MainActor
    init() {
        self.storyUsecase = ImplementedStoryUsecase.shared
        self.templateUsecase = JSONTemplateUsecase.shared
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
    
    func fetchStoryById(storyId: UUID) -> StoryEntity? {
        return storyUsecase.fetchStoryById(storyId: storyId)
    }
    
    public func searchStories() {
            if searchText.isEmpty {
                displayedStory = stories // If search text is empty, show all stories
            } else {
                displayedStory = stories.filter { story in
                    story.storyName.lowercased().contains(searchText.lowercased()) ||
                    story.templateCategory.lowercased().contains(searchText.lowercased())
                }
            }
        
        displayedStory.insert(StoryEntity(storyId: UUID(),
                                          storyName: "",
                                          storyCoverImagePath: "",
                                          storyLastRead: Date(),
                                          templateId: UUID(),
                                          templateCategory: "",
                                          pages: []
                                         ), at: 0)
            objectWillChange.send() // Notify observers
        }
    
    func sortDisplayedStories() {
            guard displayedStory.count > 1 else {
                return // No need to sort if there's only one or no stories
            }
            
            let storiesToSort = displayedStory[1...] // Skip the first element
            
            switch selectedOption {
            case .newest:
                displayedStory = [displayedStory[0]] + storiesToSort.sorted(by: { $0.storyLastRead > $1.storyLastRead })
            case .oldest:
                displayedStory = [displayedStory[0]] + storiesToSort.sorted(by: { $0.storyLastRead < $1.storyLastRead })
            }

            objectWillChange.send()
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
    
    public func getImagePreviewSelection(templateId: UUID) -> [String] {
        if let template = templateUsecase.fetchTemplateById(templateId: templateId) {
            return template.templateOptionCoverImagePath
        }
        
        return []
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
