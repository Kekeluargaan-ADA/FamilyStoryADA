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
    var componentRatio: RatioEntity?
    var componentScale: Double?
    var componentRotation: Double?
    
    init(componentId: UUID, componentContent: String, componentRatio: RatioEntity?, componentScale: Double?, componentRotation: Double?) {
        self.componentId = componentId
        self.componentContent = componentContent
        self.componentRatio = componentRatio
        self.componentScale = componentScale
        self.componentRotation = componentRotation
    }
}
