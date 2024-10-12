//
//  TextComponent.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 09/10/24.
//

import Foundation
import SwiftData

@Model
class TextComponent: StoryComponent {
    var componentId: UUID
    
    var componentContent: String
    
    var componentRatio: Ratio
    
    var componentScale: Double
    
    var componentRotation: Double
    
    init(componentId: UUID, componentContent: String, componentRatio: Ratio, componentScale: Double, componentRotation: Double) {
        self.componentId = componentId
        self.componentContent = componentContent
        self.componentRatio = componentRatio
        self.componentScale = componentScale
        self.componentRotation = componentRotation
    }
    
    init(template: ComponentJSONObject) {
        self.componentId = template.componentId
        self.componentContent = template.componentContent
        self.componentRatio = Ratio(template: template.componentRatio)
        self.componentScale = template.componentScale
        self.componentRotation = template.componentRotation
    }
}
