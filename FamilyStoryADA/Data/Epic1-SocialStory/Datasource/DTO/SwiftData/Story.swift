//
//  Story.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 10/10/24.
//

import Foundation
import SwiftData

@Model
public class StorySwiftData: Identifiable, ISwiftDataAble {
    var storyId: UUID
    var storyName: String
    var storyLastRead: Date
    var templateId: UUID
    var templateCategory: String
    var pages: [UUID]
    
    init(storyId: UUID, storyName: String, storyLastRead: Date, templateId: UUID, templateCategory: String, pages: [UUID]) {
        self.storyId = storyId
        self.storyName = storyName
        self.storyLastRead = storyLastRead
        self.templateId = templateId
        self.templateCategory = templateCategory
        self.pages = pages
    }
    
//    init (template: TemplateJSONObject) {
//        self.storyId = UUID()
//        self.storyName = ""
//        self.storyLastRead = Date()
//        self.templateId = template.templateId
//        self.templateCategory = template.templateCategory
//        self.pages = []
//        
//        setupDefaultStory(template: template)
//    }
//    
//    fileprivate func setupDefaultStory(template: TemplateJSONObject) {
//        for page in template.templatePage {
//            let page = PageSwiftData(template: page)
//            self.pages.append(page.pageId)
//        }
//    }
    
//    func convertToSwiftData(jsonTemplate: any IJSONAble) -> any ISwiftDataAble {
//        <#code#>
//    }
//    
//    func convertToSwiftData(entity: any IEntityAble) -> any ISwiftDataAble {
//        <#code#>
//    }
//    
//    func convertToEntity() -> any IEntityAble {
//        <#code#>
//    }
}
