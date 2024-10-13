//
//  StoryUsecase.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 13/10/24.
//

import Foundation


protocol StoryUsecase {
    func fetchStories() -> [Story]
    func fetchStoryById(storyId: UUID) -> Story?
    func addNewStory(templateId: UUID) -> UUID?
    func removeStory(storyId: UUID) -> Bool
}

// TODO: Make ImplementedStoryUsecase

class DummyStoryUsecase: StoryUsecase {
    
    private var storyRepository: StoryRepository
    
    init() {
        storyRepository = DummyStoryRepository()
    }
    
    func fetchStories() -> [Story] {
        let (stories, error) = storyRepository.fetchStories()
        
        guard error == nil else {
            return []
        }
        return stories
    }
    
    func fetchStoryById(storyId: UUID) -> Story? {
        let (story, error) = storyRepository.fetchStoriesById(storyId: storyId)
        
        guard error == nil else {
            return nil
        }
        return story
    }
    
    func addNewStory(templateId: UUID) -> UUID? {
        let (storyId, error) = storyRepository.addNewStory(templateId: templateId)
        
        guard error == nil else {
            return nil
        }
        return storyId
    }
    
    func removeStory(storyId: UUID) -> Bool {
        let error = storyRepository.removeStoryById(storyId: storyId)
        
        guard error == nil else {
            return false
        }
        return true
    }
    
    
}
