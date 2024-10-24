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
    
    var componentCategory: String
    
    var componentRatioId: UUID?
    
    var componentScale: Double?
    
    var componentRotation: Double?
    
    init(componentId: UUID, componentContent: String, componentCategory: String, componentRatioId: UUID? = nil, componentScale: Double? = nil, componentRotation: Double? = nil) {
        self.componentId = componentId
        self.componentContent = componentContent
        self.componentCategory = componentCategory
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
        let repo = SwiftDataRatioRepository.shared
        let ratio = RatioSwiftData.convertToSwiftData(jsonTemplate: jsonTemplate.componentRatio)
        //MARK: Saving sub-types
        _ = repo.addNewRatio(ratio: ratio)
        return StoryComponentSwiftData(componentId: UUID(),
                                       componentContent: jsonTemplate.componentContent,
                                       componentCategory: jsonTemplate.componentCategory,
                                       componentRatioId: ratio.ratioId,
                                       componentScale: jsonTemplate.componentScale,
                                       componentRotation: jsonTemplate.componentRotation
        )
    }
    
    static func convertToSwiftData(entity: StoryComponentEntity) -> StoryComponentSwiftData {
        return StoryComponentSwiftData(componentId: entity.componentId,
                                       componentContent: entity.componentContent,
                                       componentCategory: entity.componentCategory,
                                       componentRatioId: entity.componentRatio?.ratioId,
                                       componentScale: entity.componentScale,
                                       componentRotation: entity.componentRotation
        )
    }
    
    func convertToEntity(type: StoryComponentType) -> StoryComponentEntity {
        let repo = SwiftDataRatioRepository.shared
        let ratio = repo.fetchRatioById(ratioId: self.componentRatioId ?? UUID()).0
        switch type {
        case .picture:
            return PictureComponentEntity(componentId: self.componentId,
                                          componentContent: self.componentContent,
                                          componentCategory: self.componentCategory,
                                          componentRatio: ratio?.convertToEntity(),
                                          componentScale: self.componentScale,
                                          componentRotation: self.componentRotation
            )
        case .text:
            return TextComponentEntity(componentId: self.componentId,
                                       componentContent: self.componentContent,
                                       componentCategory: self.componentCategory,
                                       componentRatio: ratio?.convertToEntity(),
                                       componentScale: self.componentScale,
                                       componentRotation: self.componentRotation
            )
        case .video:
            return VideoComponentEntity(componentId: self.componentId,
                                        componentContent: self.componentContent,
                                        componentCategory: self.componentCategory,
                                        componentRatio: ratio?.convertToEntity(),
                                        componentScale: self.componentScale,
                                        componentRotation: self.componentRotation
            )
        }
    }
}
