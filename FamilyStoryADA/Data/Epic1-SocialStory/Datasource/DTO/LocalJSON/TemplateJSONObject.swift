//
//  TemplateJSONObject.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 09/10/24.
//

import Foundation

struct TemplateJSONObject: Codable, IJSONAble {
    let templateId: UUID
    let templateName: String
    let templateCategory: String
    let templatePage: [PageJSONObject]
}
