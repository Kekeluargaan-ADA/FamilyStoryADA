//
//  Story.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 14/10/24.
//

import Foundation

class StoryEntity: IEntityAble, Identifiable {
    var storyId: UUID
    var storyName: String
    var storyCoverImagePath: String
    var storyLastRead: Date
    var templateId: UUID
    var templateCategory: String
    var isStoryGameable: Bool
    var pages: [PageEntity]
    var storyResultImagePath: String
    
    var storyLength: Double {
        guard !pages.isEmpty else  {
            return 0
        }
        var wordCount = 0
        for page in pages {
            wordCount += page.componentTextWordCount
        }
        
        let length = Double(wordCount) / 50 // TODO: Research about WPM
        return length < 1.0 ? 1 : length
    }
    
    init(storyId: UUID, storyName: String, storyCoverImagePath: String, storyLastRead: Date, templateId: UUID, templateCategory: String, isStoryGameable: Bool, pages: [PageEntity], storyResultImagePath: String) {
        self.storyId = storyId
        self.storyName = storyName
        self.storyCoverImagePath = storyCoverImagePath
        self.storyLastRead = storyLastRead
        self.templateId = templateId
        self.templateCategory = templateCategory
        self.isStoryGameable = isStoryGameable
        self.pages = pages
        self.storyResultImagePath = storyResultImagePath
    }
}
