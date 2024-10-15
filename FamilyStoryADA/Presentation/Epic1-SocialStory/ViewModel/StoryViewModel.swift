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
    
    private let storyUsecase: StoryUsecase
    
    @MainActor
    init() {
        self.storyUsecase = ImplementedStoryUsecase()
        self.stories = storyUsecase.fetchStories()
        self.displayedStory = [StoryEntity]()
        
        updateStoryDisplay()
    }
    
    func updateStoryDisplay() {
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
    }
}
