//
//  StoryComponent.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 14/10/24.
//

import Foundation

public class StoryComponentEntity: IEntityAble {
    var componentId: UUID
    var componentContent: String
    var componentCategory: String
    var componentRatio: RatioEntity?
    var componentScale: Double?
    var componentRotation: Double?
    
    init(componentId: UUID, componentContent: String, componentCategory: String, componentRatio: RatioEntity? = nil, componentScale: Double? = nil, componentRotation: Double? = nil) {
        self.componentId = componentId
        self.componentContent = componentContent
        self.componentCategory = componentCategory
        self.componentRatio = componentRatio
        self.componentScale = componentScale
        self.componentRotation = componentRotation
    }
}
