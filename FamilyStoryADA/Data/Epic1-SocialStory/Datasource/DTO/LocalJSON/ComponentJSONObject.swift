//
//  ComponentJSONObject.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 09/10/24.
//

import Foundation

struct ComponentJSONObject: Codable, IJSONAble {
    let componentContent: String
    let componentRatio: RatioJSONObject
    let componentScale: Double
    let componentRotation: Double
}
