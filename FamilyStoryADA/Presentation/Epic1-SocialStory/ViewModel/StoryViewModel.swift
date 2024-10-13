//
//  StoryViewModel.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 13/10/24.
//

import Foundation

enum SortOption {
    case newest, oldest
}

class StoryViewModel: ObservableObject {
    @Published var stories: [Story] = []
    @Published var displayedStory: [Story]
    
    @Published var selectedOption: SortOption = .newest
    
    private let storyUsecase: StoryUsecase
    
    init() {
        storyUsecase = DummyStoryUsecase()
        stories = storyUsecase.fetchStories()
        displayedStory = [Story]()
        
        updateStoryDisplay()
    }
    
    func updateStoryDisplay() {
        displayedStory = [Story]()
        displayedStory.append(Story(storyId: UUID(), templateId: UUID(), templateCategory: "", pages: []))
        displayedStory.append(contentsOf: stories)
    }
}
