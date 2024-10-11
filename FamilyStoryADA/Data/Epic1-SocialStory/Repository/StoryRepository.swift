//
//  StoryRepository.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 10/10/24.
//

import Foundation
import SwiftData
import SwiftUICore

internal protocol StoryRepository {
    func fetchStories() -> ([Story], ErrorHandler?)
    func fetchStoriesById(storyId: UUID) -> (Story?, ErrorHandler?)
    func removeStoryById(storyId: UUID) -> ErrorHandler?
    func addNewStory(templateId: UUID) -> (UUID?, ErrorHandler?)
}

internal final class SwiftDataStoryRepository: StoryRepository {
    
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    static let shared = SwiftDataStoryRepository()
    
    @MainActor
    private init() {
        // TODO: Handle error
        self.modelContainer = try! ModelContainer(for: Story.self)
        self.modelContext = modelContainer.mainContext
    }
    
    func fetchStories() -> ([Story], ErrorHandler?) {
        do {
            let stories = try modelContext.fetch(FetchDescriptor<Story>())
            return (stories, nil)
        } catch {
            return ([], ErrorHandler.fileNotFound)
        }
    }
    
    func fetchStoriesById(storyId: UUID) -> (Story?, ErrorHandler?) {
        let (stories, errorHandler) = fetchStories()
        
        if let error = errorHandler {
            return (nil, error)
        }
        
        let story = stories.filter {
            $0.storyId == storyId
        }.first
        
        guard story != nil else {
            return (nil, ErrorHandler.fileNotFound)
        }
        
        return (story, nil)
    }
    
    func removeStoryById(storyId: UUID) -> ErrorHandler? {
        let (data, errorHandler) = fetchStoriesById(storyId: storyId)
        
        if let error = errorHandler {
            return error
        }
        
        if let deletedData = data {
            modelContext.delete(deletedData)
        }
        return nil
    }
    
    func addNewStory(templateId: UUID) -> (UUID?, ErrorHandler?) {
        let templateRepository = JSONTemplateRepository()
        let (template, errorHandler) = templateRepository.fetchTemplatesById(templateId: templateId)
        
        if let error = errorHandler {
            return (nil, error)
        }
        
        if let storyTemplate = template {
            let newStory = Story(template: storyTemplate)
            modelContext.insert(newStory)
            do {
                try modelContext.save()
            } catch {
                return (nil, errorHandler)
            }
            return (newStory.storyId, nil)
        }
        
        return (nil, errorHandler)
    }
}
