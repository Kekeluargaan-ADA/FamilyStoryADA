//
//  Component.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 09/10/24.
//

import Foundation
import SwiftData

protocol StoryComponent: PersistentModel {
    var componentId: UUID {get set}
    var componentContent: String {get set}
    var componentRatio: Ratio {get set}
    var componentScale: Double {get set}
    var componentRotation: Double {get set}        // 0 - 360
}
