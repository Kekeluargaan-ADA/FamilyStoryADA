//
//  StoryUsecase.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 13/10/24.
//

import Foundation
import SwiftData


protocol StoryUsecase {
    func fetchStories() -> [StoryEntity]
    func fetchStoryById(storyId: UUID) -> StoryEntity?
    func addNewStory(templateId: UUID) -> UUID?
    func removeStory(storyId: UUID) -> Bool
}

// TODO: Fix

class ImplementedStoryUsecase: StoryUsecase {
    private let repository: StoryRepository
    
    @MainActor
    init() {
        self.repository = SwiftDataStoryRepository()
    }
    
    func fetchStories() -> [StoryEntity] {
        let (stories, error) = repository.fetchStories()
        
        guard error == nil else {
            return []
        }
//        return stories
        return []
    }
    
    func fetchStoryById(storyId: UUID) -> StoryEntity? {
        let (story, error) = repository.fetchStoriesById(storyId: storyId)
        
        guard error == nil else {
            return nil
        }
//        return story
        return nil
    }
    
    func addNewStory(templateId: UUID) -> UUID? {
        //TODO: Fix repo - usecase connection
//        let (storyId, error) = repository.addNewStory(templateId: templateId)
//        
//        guard error == nil else {
//            return nil
//        }
//        return storyId
        return nil
    }
    
    func removeStory(storyId: UUID) -> Bool {
        let error = repository.removeStoryById(storyId: storyId)
        
        guard error == nil else {
            return false
        }
        return true
    }
}

class DummyStoryUsecase: StoryUsecase {
    
    private var storyRepository: StoryRepository
    
    init() {
        storyRepository = DummyStoryRepository()
    }
    
    func fetchStories() -> [StoryEntity] {
        let (stories, error) = storyRepository.fetchStories()
        
        guard error == nil else {
            return []
        }
//        return stories
        return []
    }
    
    func fetchStoryById(storyId: UUID) -> StoryEntity? {
        let (story, error) = storyRepository.fetchStoriesById(storyId: storyId)
        
        guard error == nil else {
            return nil
        }
//        return story
        return nil
    }
    
    func addNewStory(templateId: UUID) -> UUID? {
//        let (storyId, error) = storyRepository.addNewStory(templateId: templateId)
//        
//        guard error == nil else {
//            return nil
//        }
        return UUID()
    }
    
    func removeStory(storyId: UUID) -> Bool {
        let error = storyRepository.removeStoryById(storyId: storyId)
        
        guard error == nil else {
            return false
        }
        return true
    }
    
    
}
