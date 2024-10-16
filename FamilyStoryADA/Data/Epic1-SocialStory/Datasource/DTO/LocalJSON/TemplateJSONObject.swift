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
    let templateDescription: String
    let templateCategory: String
    let templatePage: [PageJSONObject]
    let templateCoverImagePath: String
    let templateOptionCoverImagePath: [String]
    let templatePreviewImagePath: [String]
}
