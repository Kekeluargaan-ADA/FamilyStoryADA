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
    func fetchStories() -> ([StorySwiftData], ErrorHandler?)
    func fetchStoriesById(storyId: UUID) -> (StorySwiftData?, ErrorHandler?)
    func removeStoryById(storyId: UUID) -> ErrorHandler?
    func addNewStory(story: StorySwiftData) -> (UUID?, ErrorHandler?)
    func saveStory() -> ErrorHandler?
}

internal final class SwiftDataStoryRepository: StoryRepository {
    
    private let swiftDataManager = SwiftDataManager.shared
    
    func fetchStories() -> ([StorySwiftData], ErrorHandler?) {
        do {
            let stories = try swiftDataManager.context.fetch(FetchDescriptor<StorySwiftData>())
            print(stories)
            return (stories, nil)
        } catch {
            return ([], ErrorHandler.fileNotFound)
        }
    }
    
    func fetchStoriesById(storyId: UUID) -> (StorySwiftData?, ErrorHandler?) {
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
            swiftDataManager.context.delete(deletedData)
        }
        return nil
    }
    
    func addNewStory(story: StorySwiftData) -> (UUID?, ErrorHandler?) {
        swiftDataManager.context.insert(story)
        
        return (story.storyId, nil)
    }
    
    func saveStory() -> ErrorHandler? {
        do {
            try swiftDataManager.context.save()
        } catch {
            return ErrorHandler.dataCorrupted
        }
        
        return nil
    }
}

internal class DummyStoryRepository: StoryRepository {
    func fetchStories() -> ([StorySwiftData], ErrorHandler?) {
        return (
//            [
//                Story(
//                    storyId: UUID(),
//                    templateId: UUID(),
//                    templateCategory: "Hygiene",
//                    pages: [
//                        Page(pageId: UUID(),
//                             pageText: [
//                                TextComponent(
//                                    componentId: UUID(),
//                                    componentContent: "Dummy Text",
//                                    componentRatio: Ratio(xRatio: 0.5,
//                                                          yRatio: 0.5,
//                                                          zRatio: 1
//                                                         ),
//                                    componentScale: 1.5,
//                                    componentRotation: 0
//                                )
//                             ], pagePicture: [
//                                PictureComponent(
//                                    componentId: UUID(),
//                                    componentContent: "DummyImage",
//                                    componentRatio: Ratio(xRatio: 0.5,
//                                                          yRatio: 0.5,
//                                                          zRatio: 1
//                                                         ),
//                                    componentScale: 1.5,
//                                    componentRotation: 0
//                                )
//                             ], pageVideo: [],
//                             pageSoundPath: "DummySound"
//                            )
//                    ]
//                )
//            ],
            [], nil
        )
    }
    
    func fetchStoriesById(storyId: UUID) -> (StorySwiftData?, ErrorHandler?) {
        let (stories, error) = self.fetchStories()
        
        guard error == nil else { return (nil, error) }
        
        return (stories.first(where: {$0.storyId == storyId} ), nil)
    }
    
    func removeStoryById(storyId: UUID) -> ErrorHandler? {
        return nil
    }
    
    func addNewStory(story: StorySwiftData) -> (UUID?, ErrorHandler?) {
        return (UUID(), nil)
    }
    
    func saveStory() -> ErrorHandler? {
        return nil
    }
}
