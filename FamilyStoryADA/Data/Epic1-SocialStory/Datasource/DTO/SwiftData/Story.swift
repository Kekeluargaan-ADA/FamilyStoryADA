//
//  Story.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 10/10/24.
//

import Foundation
import SwiftData

@Model
public class Story {
    var storyId: UUID
    var templateId: UUID
    var templateCategory: String
    var pages: [Page]
    
    init(storyId: UUID, templateId: UUID, templateCategory: String, pages: [Page]) {
        self.storyId = storyId
        self.templateId = templateId
        self.templateCategory = templateCategory
        self.pages = pages
    }
    
    init (template: TemplateJSONObject) {
        self.storyId = UUID()
        self.templateId = template.templateId
        self.templateCategory = template.templateCategory
        self.pages = []
        
        setupDefaultStory(template: template)
    }
    
    fileprivate func setupDefaultStory(template: TemplateJSONObject) {
        for page in template.templatePage {
            self.pages.append(Page(template: page))
        }
    }
}
