//
//  Component.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 09/10/24.
//

import Foundation
import SwiftData

enum StoryComponentType {
    case picture, text, video
}

@Model
class StoryComponentSwiftData: Identifiable, ISwiftDataAble {
    
    var componentId: UUID
    
    var componentContent: String
    
    var componentRatioId: UUID?
    
    var componentScale: Double?
    
    var componentRotation: Double?
    
    init(componentId: UUID, componentContent: String, componentRatioId: UUID?, componentScale: Double?, componentRotation: Double?) {
        self.componentId = componentId
        self.componentContent = componentContent
        self.componentRatioId = componentRatioId
        self.componentScale = componentScale
        self.componentRotation = componentRotation
    }
    
//    init(template: ComponentJSONObject) {
//        let ratio = RatioSwiftData(template: template.componentRatio)
//        self.componentId = UUID()
//        self.componentContent = template.componentContent
//        self.componentRatioId = ratio.ratioId
//        self.componentScale = template.componentScale
//        self.componentRotation = template.componentRotation
//    }
    
    static func convertToSwiftData(jsonTemplate: ComponentJSONObject) -> StoryComponentSwiftData {
        let ratio = RatioSwiftData.convertToSwiftData(jsonTemplate: jsonTemplate.componentRatio)
        return StoryComponentSwiftData(componentId: UUID(),
                                       componentContent: jsonTemplate.componentContent,
                                       componentRatioId: ratio.ratioId,
                                       componentScale: jsonTemplate.componentScale,
                                       componentRotation: jsonTemplate.componentRotation
        )
    }
    
    static func convertToSwiftData(entity: StoryComponentEntity) -> StoryComponentSwiftData {
        return StoryComponentSwiftData(componentId: entity.componentId,
                                       componentContent: entity.componentContent,
                                       componentRatioId: entity.componentRatio?.ratioId,
                                       componentScale: entity.componentScale,
                                       componentRotation: entity.componentRotation
        )
    }
    
//    func convertToEntity(type: StoryComponentType) -> StoryComponentEntity {
//        switch type {
//        case .picture:
//            return PictureComponentEntity(componentId: self.componentId,
//                                          componentContent: self.componentContent,
//                                          componentRatio: <#T##RatioEntity?#>,
//                                          componentScale: self.componentScale,
//                                          componentRotation: self.componentRotation
//            )
//        case .text:
//            return TextComponentEntity(componentId: self.componentId,
//                                          componentContent: self.componentContent,
//                                          componentRatio: <#T##RatioEntity?#>,
//                                          componentScale: self.componentScale,
//                                          componentRotation: self.componentRotation
//            )
//        case .video:
//            return VideoComponentEntity(componentId: self.componentId,
//                                          componentContent: self.componentContent,
//                                          componentRatio: <#T##RatioEntity?#>,
//                                          componentScale: self.componentScale,
//                                          componentRotation: self.componentRotation
//            )
//        }
//    }
}
