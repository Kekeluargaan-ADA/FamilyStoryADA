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
    var storyCoverImagePath: String
    var storyLastRead: Date
    var templateId: UUID
    var templateCategory: String
    var pages: [UUID]
    
    init(storyId: UUID, storyName: String, storyCoverImagePath: String, storyLastRead: Date, templateId: UUID, templateCategory: String, pages: [UUID]) {
        self.storyId = storyId
        self.storyName = storyName
        self.storyCoverImagePath = storyCoverImagePath
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
    
    static private func convertToUUIDArray(templatePages: [PageJSONObject]) -> [UUID] {
        let repo = SwiftDataPageRepository.shared
        var array: [UUID] = []
        for templatePage in templatePages {
            let page = PageSwiftData.convertToSwiftData(jsonTemplate: templatePage)
            //MARK: Save Sub-types
            _ = repo.addNewPage(page: page)
            array.append(page.pageId)
        }
        return array
    }
    
    static func convertToSwiftData(jsonTemplate: TemplateJSONObject) -> StorySwiftData {
        return StorySwiftData(storyId: UUID(),
                              storyName: jsonTemplate.templateName,
                              storyCoverImagePath: jsonTemplate.templateCoverImagePath,
                              storyLastRead: Date(),
                              templateId: jsonTemplate.templateId,
                              templateCategory: jsonTemplate.templateCategory,
                              pages: convertToUUIDArray(templatePages: jsonTemplate.templatePage
                                                       )
        )
    }
    
    static private func convertToUUIDArray(pageEntities: [PageEntity]) -> [UUID] {
        var array: [UUID] = []
        for pageEntity in pageEntities {
            array.append(pageEntity.pageId)
        }
        return array
    }
    
    static func convertToSwiftData(entity: StoryEntity) -> StorySwiftData {
        return StorySwiftData(storyId: entity.storyId,
                              storyName: entity.storyName,
                              storyCoverImagePath: entity.storyCoverImagePath,
                              storyLastRead: entity.storyLastRead,
                              templateId: entity.templateId,
                              templateCategory: entity.templateCategory,
                              pages: convertToUUIDArray(pageEntities: entity.pages)
        )
    }
    
    private func convertToEntitiesArray(pageIds: [UUID]) -> [PageEntity] {
        let repo = SwiftDataPageRepository.shared
        
        var array: [PageEntity] = []
        for id in pageIds {
            let page = repo.fetchPageById(pageId: id)
            
            if let result = page.0 {
                array.append(result.convertToEntity())
            }
        }
        return array
    }
    
    func convertToEntity() -> StoryEntity {
        return StoryEntity(storyId: self.storyId,
                           storyName: self.storyName,
                           storyCoverImagePath: self.storyCoverImagePath,
                           storyLastRead: self.storyLastRead,
                           templateId: self.templateId,
                           templateCategory: self.templateCategory,
                           pages: convertToEntitiesArray(pageIds: self.pages)
        )
    }
}
