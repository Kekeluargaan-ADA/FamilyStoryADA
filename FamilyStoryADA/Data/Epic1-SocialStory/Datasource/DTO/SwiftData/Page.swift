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
    var pageText: [UUID]
    var pagePicture: [UUID]
    var pageVideo: [UUID]
    var pageSoundPath: String
    
    init (pageId: UUID, pageText: [UUID], pagePicture: [UUID], pageVideo: [UUID], pageSoundPath: String) {
        self.pageId = pageId
        self.pageText = pageText
        self.pagePicture = pagePicture
        self.pageVideo = pageVideo
        self.pageSoundPath = pageSoundPath
    }
    
    init (template: PageJSONObject) {
        self.pageId = UUID()
        self.pageText = []
        self.pagePicture = []
        self.pageVideo = []
        self.pageSoundPath = template.pageSoundPath
        
//        setupPage(template: template)
    }
    
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
