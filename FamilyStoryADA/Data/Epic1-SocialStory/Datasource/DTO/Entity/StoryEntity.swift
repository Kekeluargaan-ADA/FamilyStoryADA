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
    var pages: [PageEntity]
    
    var storyLength: Double {
        guard !pages.isEmpty else  {
            return 0
        }
        var wordCount = 0
        for page in pages {
            wordCount += page.componentTextWordCount
        }
        
        let length = Double(wordCount) / 100 // TODO: Research about WPM
        return length < 1.0 ? 1 : length
    }
    
    init(storyId: UUID, storyName: String, storyCoverImagePath: String, storyLastRead: Date, templateId: UUID, templateCategory: String, pages: [PageEntity]) {
        self.storyId = storyId
        self.storyName = storyName
        self.storyCoverImagePath = storyCoverImagePath
        self.storyLastRead = storyLastRead
        self.templateId = templateId
        self.templateCategory = templateCategory
        self.pages = pages
    }
}
