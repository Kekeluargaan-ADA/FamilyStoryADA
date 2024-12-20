//
//  Scene.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 09/10/24.
//

import Foundation
import SwiftData

@Model
class PageSwiftData: Identifiable, ISwiftDataAble {
    
    var pageId: UUID
    var pageType: String
    var pageText: [UUID]
    var pagePicture: [UUID]
    var pageVideo: [UUID]
    var pageSoundPath: String
    var pageTextClassification: String
    
    init(pageId: UUID, pageType: String, pageText: [UUID], pagePicture: [UUID], pageVideo: [UUID], pageSoundPath: String, pageTextClassification: String) {
        self.pageId = pageId
        self.pageType = pageType
        self.pageText = pageText
        self.pagePicture = pagePicture
        self.pageVideo = pageVideo
        self.pageSoundPath = pageSoundPath
        self.pageTextClassification = pageTextClassification
    }
    
//    init (template: PageJSONObject) {
//        self.pageId = UUID()
//        self.pageText = []
//        self.pagePicture = []
//        self.pageVideo = []
//        self.pageSoundPath = template.pageSoundPath
//        
//        setupPage(template: template)
//    }
    
//    fileprivate func setupPage(template: PageJSONObject) {
//        for text in template.pageText {
//            let textComponent = StoryComponentSwiftData(template: text)
//            pageText.append(textComponent.componentId)
//        }
//
//        for picture in template.pagePicture {
//            let pictureComponent = StoryComponentSwiftData(template: picture)
//            pagePicture.append(pictureComponent.componentId)
//        }
//
//        for video in template.pageVideo {
//            let videoComponent = StoryComponentSwiftData(template: video)
//            pageVideo.append(videoComponent.componentId)
//        }
//    }
    
    static func convertToSwiftData(jsonTemplate: PageJSONObject) -> PageSwiftData {
        return PageSwiftData(pageId: UUID(),
                             pageType: jsonTemplate.pageType,
                             pageText: convertToUUIDArray(jsonTemplate: jsonTemplate.pageText),
                             pagePicture: convertToUUIDArray(jsonTemplate: jsonTemplate.pagePicture),
                             pageVideo: convertToUUIDArray(jsonTemplate: jsonTemplate.pageVideo),
                             pageSoundPath: jsonTemplate.pageSoundPath,
                             pageTextClassification: "Descriptive"
        )
    }
    
    static private func convertToUUIDArray(jsonTemplate: [ComponentJSONObject]) -> [UUID] {
        let repo = SwiftDataComponentRepository.shared
        var array: [(UUID)] = []
        for object in jsonTemplate {
            let component = StoryComponentSwiftData.convertToSwiftData(jsonTemplate: object)
            //MARK: Saving sub-types
            _ = repo.addNewComponent(component: component)
            array.append(component.componentId)
        }
        return array
    }
    
    static func convertToSwiftData(entity: PageEntity) -> PageSwiftData {
        return PageSwiftData(pageId: entity.pageId,
                             pageType: entity.pageType,
                             pageText: convertToUUIDArray(entities: entity.pageText),
                             pagePicture: convertToUUIDArray(entities: entity.pagePicture),
                             pageVideo: convertToUUIDArray(entities: entity.pageVideo),
                             pageSoundPath: entity.pageSoundPath,
                             pageTextClassification: entity.pageTextClassification
        )
    }
    
    static private func convertToUUIDArray(entities: [StoryComponentEntity]) -> [UUID] {
        var array: [UUID] = []
        for entity in entities {
            array.append(entity.componentId)
        }
        return array
    }
    
    func convertToEntity() -> PageEntity {
        return PageEntity(pageId: self.pageId,
                          pageType: self.pageType,
                          pageText: convertToEntitiesArray(componentIds: self.pageText, type: .text) as! [TextComponentEntity],
                          pagePicture: convertToEntitiesArray(componentIds: self.pagePicture, type: .picture) as! [PictureComponentEntity],
                          pageVideo: convertToEntitiesArray(componentIds: self.pageVideo, type: .video) as! [VideoComponentEntity],
                          pageSoundPath: self.pageSoundPath,
                          pageTextClassification: self.pageTextClassification
        )
    }
    
    private func convertToEntitiesArray(componentIds: [(UUID)], type: StoryComponentType) -> [StoryComponentEntity] {
        let repo = SwiftDataComponentRepository.shared
        
        var array: [StoryComponentEntity] = []
        for id in componentIds {
            let component = repo.fetchComponentById(componentId: id)
            
            if let result = component.0 {
                array.append(result.convertToEntity(type: type))
            }
        }
        return array
    }
}
