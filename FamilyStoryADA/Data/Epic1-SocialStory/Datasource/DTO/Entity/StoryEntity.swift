//
//  Story.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 14/10/24.
//

import Foundation

class StoryEntity: IEntityAble {
    var storyId: UUID
    var storyName: String
    var storyLastRead: Date
    var templateId: UUID
    var templateCategory: String
    var pages: [PageEntity]
    
    init(storyId: UUID, storyName: String, storyLastRead: Date, templateId: UUID, templateCategory: String, pages: [PageEntity]) {
        self.storyId = storyId
        self.storyName = storyName
        self.storyLastRead = storyLastRead
        self.templateId = templateId
        self.templateCategory = templateCategory
        self.pages = pages
    }
}
